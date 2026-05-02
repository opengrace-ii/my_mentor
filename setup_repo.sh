#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# My Mentor — GitHub Repository Setup Script
# Run this ONCE on your Mac Mini M4 to create the full project
# Command: chmod +x setup_repo.sh && ./setup_repo.sh
# ═══════════════════════════════════════════════════════════════

set -e  # Stop on any error

PROJECT="my-mentor"
echo "🎓 Creating My Mentor project structure..."

mkdir -p $PROJECT && cd $PROJECT

# ── ROOT FILES ──────────────────────────────────────────────────
touch CLAUDE.md          # Virtual brain — copy from provided CLAUDE.md
touch README.md
touch .gitignore
touch .env.example

# ── BACKEND ─────────────────────────────────────────────────────
mkdir -p backend/src/{api,core,db,ingest,rag,mentor,mcp,camera,voice,avatar,reports}
mkdir -p backend/src/api/{routes,schemas,middleware}
mkdir -p backend/src/db/{models,migrations}
mkdir -p backend/tests/{unit,integration}
mkdir -p backend/config
touch backend/requirements.txt
touch backend/Dockerfile
touch backend/alembic.ini

# API routes
touch backend/src/api/routes/{students,sessions,curriculum,camera,health}.py
touch backend/src/api/schemas/{student,session,curriculum}.py
touch backend/src/api/middleware/{auth,rate_limit,logging}.py
touch backend/src/api/main.py

# Core
touch backend/src/core/{config,security,logging,exceptions}.py

# Database
touch backend/src/db/models/{student,session,curriculum,progress,user}.py
touch backend/src/db/{database,base}.py

# Ingestion
touch backend/src/ingest/{ingest_textbook,chunker,embedder}.py

# RAG
touch backend/src/rag/{retriever,reranker,prompt_builder}.py

# Mentor (core teaching brain)
touch backend/src/mentor/{teacher,persona,response_evaluator,session_manager}.py

# MCP servers
touch backend/src/mcp/{mcp_curriculum,mcp_student_memory,mcp_emotion_state,mcp_tts_control,mcp_parent_report}.py

# Camera (Xiaomi 360 integration)
touch backend/src/camera/{xiaomi_bridge,stream_processor,attention_detector,emotion_detector,motion_tracker}.py

# Voice
touch backend/src/voice/{stt_whisper,tts_coqui,accent_manager,language_switcher}.py

# Avatar
touch backend/src/avatar/{lip_sync,expression_mapper,avatar_controller}.py

# Reports
touch backend/src/reports/{session_report,weekly_report,progress_chart}.py

# Config files
touch backend/config/{settings,prompts,curriculum_cbse_g1,student_cristin,camera_xiaomi}.yaml

# Tests
touch backend/tests/unit/{test_rag,test_teacher,test_camera,test_voice}.py
touch backend/tests/integration/{test_session_flow,test_camera_pipeline}.py

# ── FRONTEND ────────────────────────────────────────────────────
mkdir -p frontend/src/{app,components,hooks,lib,stores,types}
mkdir -p frontend/src/app/{dashboard,session,login,parent,admin}
mkdir -p frontend/src/components/{ui,teaching,camera,avatar,charts,layout}
touch frontend/package.json
touch frontend/tailwind.config.js
touch frontend/next.config.js
touch frontend/Dockerfile
touch frontend/src/app/layout.tsx
touch frontend/src/app/page.tsx
touch frontend/src/stores/{student,session,camera}.ts
touch frontend/src/types/{student,session,curriculum}.ts

# ── DATA (git-ignored) ──────────────────────────────────────────
mkdir -p data/{textbooks,vector_db,sessions,reports,models}
touch data/.gitkeep

# ── DOCKER ──────────────────────────────────────────────────────
touch docker-compose.yml
touch docker-compose.prod.yml
mkdir -p nginx
touch nginx/nginx.conf

# ── SCRIPTS ─────────────────────────────────────────────────────
mkdir -p scripts
touch scripts/{setup_ollama,ingest_curriculum,test_camera,backup_db}.sh
chmod +x scripts/*.sh

# ── CI/CD ───────────────────────────────────────────────────────
mkdir -p .github/workflows
touch .github/workflows/{test,deploy}.yml

# ── WRITE .gitignore ────────────────────────────────────────────
cat > .gitignore << 'EOF'
# Environment
.env
.env.local
.env.production

# Data (never commit student data or models)
data/textbooks/
data/vector_db/
data/sessions/
data/reports/
data/models/

# Python
__pycache__/
*.py[cod]
*.egg-info/
.venv/
venv/
dist/
build/
.pytest_cache/
.mypy_cache/
htmlcov/
.coverage

# Node / Next.js
node_modules/
.next/
out/
frontend/.next/

# macOS
.DS_Store
*.DS_Store

# Logs
*.log
logs/

# Database files (local dev)
*.db
*.sqlite3

# ML Models (too large for git)
*.bin
*.gguf
*.pt
*.pth
*.safetensors
EOF

# ── WRITE .env.example ─────────────────────────────────────────
cat > .env.example << 'EOF'
# ── DATABASE ──────────────────────────────────────────────────
DATABASE_URL=postgresql://mentor:CHANGE_ME@localhost:5432/mymentor
REDIS_URL=redis://localhost:6379

# ── SECURITY ──────────────────────────────────────────────────
SECRET_KEY=GENERATE_WITH_openssl_rand_-hex_32
JWT_ALGORITHM=HS256
JWT_EXPIRE_MINUTES=60
JWT_REFRESH_EXPIRE_DAYS=30

# ── LLM ───────────────────────────────────────────────────────
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_MODEL=llama3.1:8b
OLLAMA_FALLBACK_MODEL=qwen2.5:7b

# ── CAMERA ────────────────────────────────────────────────────
XIAOMI_CAMERA_IP=192.168.1.XXX
XIAOMI_CAMERA_TOKEN=YOUR_MIIO_TOKEN_HERE
XIAOMI_CAMERA_MODEL=chuangmi.camera.ipc009

# ── VOICE ─────────────────────────────────────────────────────
WHISPER_MODEL=base
TTS_MODEL=tts_models/en/ljspeech/tacotron2-DDC
TTS_HINDI_MODEL=tts_models/multilingual/multi-dataset/xtts_v2

# ── PATHS ────────────────────────────────────────────────────
DATA_DIR=./data
TEXTBOOKS_DIR=./data/textbooks
VECTOR_DB_DIR=./data/vector_db
REPORTS_DIR=./data/reports

# ── ENVIRONMENT ──────────────────────────────────────────────
ENVIRONMENT=development
LOG_LEVEL=INFO
EOF

# ── WRITE docker-compose.yml ────────────────────────────────────
cat > docker-compose.yml << 'EOF'
version: '3.9'

services:
  # ── PostgreSQL + pgvector ──────────────────────────────────
  db:
    image: pgvector/pgvector:pg16
    container_name: mentor_db
    restart: unless-stopped
    environment:
      POSTGRES_DB: mymentor
      POSTGRES_USER: mentor
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./backend/src/db/init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U mentor -d mymentor"]
      interval: 10s
      timeout: 5s
      retries: 5

  # ── Redis ─────────────────────────────────────────────────
  redis:
    image: redis:7-alpine
    container_name: mentor_redis
    restart: unless-stopped
    command: redis-server --requirepass ${REDIS_PASSWORD}
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  # ── FastAPI Backend ────────────────────────────────────────
  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    container_name: mentor_backend
    restart: unless-stopped
    environment:
      DATABASE_URL: postgresql://mentor:${DB_PASSWORD}@db:5432/mymentor
      REDIS_URL: redis://:${REDIS_PASSWORD}@redis:6379
    env_file: .env
    volumes:
      - ./data:/app/data
      - ./backend/config:/app/config
    ports:
      - "8000:8000"
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy

  # ── Next.js Frontend ──────────────────────────────────────
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    container_name: mentor_frontend
    restart: unless-stopped
    environment:
      NEXT_PUBLIC_API_URL: http://localhost:8000
    ports:
      - "3000:3000"
    depends_on:
      - backend

  # ── Nginx Reverse Proxy ───────────────────────────────────
  nginx:
    image: nginx:alpine
    container_name: mentor_nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - backend
      - frontend

volumes:
  postgres_data:
  redis_data:
EOF

# ── GIT INIT ────────────────────────────────────────────────────
git init
git add .
git commit -m "[INIT]: My Mentor project structure — Phase 1 begins"

echo ""
echo "✅ Repository created successfully!"
echo ""
echo "📁 Structure:"
find . -type f | grep -v '.git' | grep -v '__pycache__' | sort | head -60
echo ""
echo "🚀 Next steps:"
echo "  1. Create GitHub repo at github.com/new"
echo "  2. git remote add origin git@github.com:YOUR_USERNAME/my-mentor.git"
echo "  3. git push -u origin main"
echo "  4. Copy CLAUDE.md content into the root CLAUDE.md file"
echo "  5. Report back to Claude — Phase 1 Task P1-D1 begins"
