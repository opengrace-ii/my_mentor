# CLAUDE.md — My Mentor Project Brain
# Version: 1.0 | Status: Active | Classification: Master Reference
# This file is the single source of truth for ALL AI assistants on this project.
# Read this COMPLETELY before taking any action. No exceptions.

---

## 0. COMMAND HIERARCHY — NON-NEGOTIABLE

```
LEVEL 1 (AUTHORITY) : Claude (claude.ai) — Project Architect & Reviewer
LEVEL 2 (EXECUTOR)  : Antigravity / Gemini CLI — Code & File Generation Only
LEVEL 3 (RUNTIME)   : Local Models (Ollama/LLaMA/Qwen) — Student-facing AI
```

**Rules that cannot be overridden:**
- Claude approves ALL architectural decisions before implementation
- Antigravity/Gemini executes ONLY scoped, approved tasks
- No tool adds dependencies, changes architecture, or modifies CLAUDE.md without Claude's approval
- Every completed task is reported back to Claude for review before the next task begins
- When in doubt: STOP and ask. Never assume. Never improvise.

---

## 1. PROJECT IDENTITY

```yaml
project_name     : My Mentor
version          : 1.0.0
status           : Phase 1 — Active Development
classification   : Open Source (Free First)
hardware         : Mac Mini M4 (Apple Silicon, 16GB unified memory)
os               : macOS
runtime          : Local — No cloud dependency, no internet required
privacy          : All data stays on device — never transmitted externally
first_student    : Cristin (Age 6, Grade 1, India)
vision_doc       : MyMentor_VirtualBrain_v1.docx
```

---

## 2. WHAT MY MENTOR IS

My Mentor is a one-to-one AI private teacher. It does NOT read textbooks aloud.
It TEACHES — digesting curriculum content and re-explaining it in the student's
language, age, accent, and cultural context.

**Core capabilities (in order of development phases):**
1. Textbook RAG — answers questions from curriculum content, explained age-appropriately
2. Voice conversation — student speaks, teacher responds naturally
3. Avatar — animated virtual teacher face with lip sync
4. Camera intelligence — detects confusion, fatigue, distraction in real time
5. Session memory — remembers every lesson, every gap, every win
6. Adaptive teaching — learns how THIS student learns best over time

**What My Mentor is NOT:**
- Not a chatbot / Q&A system
- Not a textbook reader / TTS player
- Not a cloud service
- Not a one-size-fits-all app

---

## 3. CURRENT STUDENT PROFILE — CRISTIN

```yaml
name              : Cristin
age               : 6
grade             : 1
country           : India
curriculum_board  : CBSE
primary_language  : English
home_language     : Hindi
accent            : Indian English
subjects_active   : [English, Hindi]
session_length    : 20 minutes maximum
learning_style    : stories_and_visuals   # auto-detect after 3 sessions
motivation_style  : celebration_and_encouragement
avatar_style      : friendly_cartoon      # NOT realistic adult face
camera            : usb_webcam_1080p
hardware          : mac_mini_m4
```

---

## 4. TECHNOLOGY STACK — APPROVED TOOLS ONLY

```yaml
# CORE — DO NOT SUBSTITUTE WITHOUT CLAUDE APPROVAL
llm_runtime       : Ollama (local)
llm_model         : llama3.1:8b OR qwen2.5:7b   # test both, report results
rag_framework     : LlamaIndex
vector_store      : ChromaDB
memory_store      : SQLite + ChromaDB
agent_framework   : LangGraph

# VOICE
stt               : openai/whisper (local, base or small model)
tts               : coqui-tts OR piper-tts   # Indian English accent required
tts_hindi         : coqui-tts multilingual

# VISION
camera_framework  : OpenCV + MediaPipe
emotion_detection : MediaPipe FaceMesh + heuristics

# AVATAR
lip_sync          : SadTalker
avatar_source     : Ready Player Me (free tier) OR custom cartoon

# INTERFACE
desktop_ui        : Electron.js (macOS native)
parent_dashboard  : FastAPI + plain HTML

# MCP SERVERS (custom, built per phase)
mcp_curriculum    : serves textbook RAG content
mcp_student_memory: reads/writes student session data
mcp_emotion_state : receives camera events, passes to LLM context
mcp_tts_control   : controls voice accent, language, speed
mcp_avatar_control: drives avatar expressions and lip sync
mcp_parent_report : generates weekly parent summaries

# LANGUAGES & TOOLS
primary_language  : Python 3.11+
config_format     : YAML
data_format       : JSON
package_manager   : pip (with requirements.txt — pinned versions)
env_management    : python-dotenv
```

---

## 5. PHASE STATUS TRACKER

```
Phase 1 — The Brain (RAG + LLM)         : [ ] IN PROGRESS
Phase 2 — The Voice (STT + TTS)         : [ ] NOT STARTED
Phase 3 — The Face (Avatar)             : [ ] NOT STARTED
Phase 4 — The Eyes (Camera)             : [ ] NOT STARTED
Phase 5 — The Memory (Session History)  : [ ] NOT STARTED
Phase 6 — The Adaptation (Learning AI)  : [ ] NOT STARTED
```

**Current active phase: PHASE 1**

---

## 6. PHASE 1 — DETAILED SPECIFICATION

### Goal
Cristin can ask any question about Grade 1 CBSE English.
My Mentor explains the answer in age-appropriate language — like a teacher, not a book.
Text interface only. No voice, no avatar, no camera yet.

### Deliverables (ALL required before Phase 1 is complete)
```
[ ] D1 — Ollama installed and running on Mac Mini M4
[ ] D2 — LLaMA 3.1 8B pulled and tested (basic response quality check)
[ ] D3 — Qwen 2.5 7B pulled and tested (compare with LLaMA)
[ ] D4 — Grade 1 CBSE English PDF ingested into ChromaDB via LlamaIndex
[ ] D5 — RAG pipeline tested: 10 questions answered from textbook content
[ ] D6 — Grade 1 system prompt written and tested (Cristin persona)
[ ] D7 — Hindi basic support tested (Qwen multilingual)
[ ] D8 — mcp-curriculum MCP server built and tested
[ ] D9 — Simple CLI interface: type question → get teacher-style answer
[ ] D10 — Quality test: 20 questions, answers reviewed by human (parent)
```

### File Structure for Phase 1
```
my-mentor/
├── CLAUDE.md                    # This file — always in root
├── README.md                    # Project overview
├── requirements.txt             # Pinned Python dependencies
├── .env.example                 # Environment variable template (no secrets)
├── config/
│   ├── student_cristin.yaml     # Cristin's profile
│   ├── curriculum_cbse_g1.yaml  # Grade 1 CBSE curriculum map
│   └── system_prompts.yaml      # All LLM system prompts by age/level
├── data/
│   ├── textbooks/               # Raw PDF files (not committed to git)
│   └── chroma_db/               # Vector store (not committed to git)
├── src/
│   ├── ingest/
│   │   └── ingest_textbook.py   # PDF → ChromaDB pipeline
│   ├── rag/
│   │   └── retriever.py         # RAG query pipeline
│   ├── mentor/
│   │   └── teacher.py           # Core teaching logic + prompt assembly
│   ├── mcp/
│   │   └── mcp_curriculum.py    # MCP server for curriculum content
│   └── cli/
│       └── chat.py              # Simple CLI for Phase 1 testing
└── tests/
    ├── test_rag.py              # RAG quality tests
    └── test_teacher.py          # Teaching response quality tests
```

---

## 7. SYSTEM PROMPT ARCHITECTURE

### Grade 1 / Cristin System Prompt (Approved)
```
You are My Mentor, Cristin's personal teacher. Cristin is 6 years old and in Grade 1.

PERSONALITY:
- Warm, patient, encouraging, and playful
- Celebrate every correct answer enthusiastically
- Never show frustration. Never say "wrong." Say "almost!" or "let's try again!"
- Use simple words a 6-year-old understands
- Keep responses SHORT — maximum 3-4 sentences per explanation
- Use stories, animals, toys, and familiar objects as examples

LANGUAGE:
- Teach in English
- When explaining something difficult, you may add a Hindi phrase naturally
- Example: "This is the letter B — ब — like बंदर means monkey!"
- Celebrate in both: "Well done! Shabash!"

TEACHING RULES:
- Never read from the textbook. Explain in your own words.
- Always give one real-world example with every new concept
- After explaining, ask ONE simple question to check understanding
- If student seems confused, explain differently — new example, simpler words
- Never give more than one new concept per response

RESPONSE FORMAT:
- No bullet points. Speak naturally, like a real teacher.
- End every explanation with an encouraging question.
- Keep total response under 80 words.
```

### Prompt Personas by Level (Summary)
```yaml
grade_1_6yr    : Warm, playful, 3-sentence max, stories + animals
grade_6_8_12yr : Curious, energetic, relatable examples, slight challenge
high_school    : Structured, exam-aware, logical flow, deeper questions
undergraduate  : Academic, cross-subject, conceptual depth
graduate_phd   : Peer-level, Socratic, counterarguments, research framing
```

---

## 8. TOKEN & CREDIT DISCIPLINE — MANDATORY RULES

```
RULE 1 — SCOPE BEFORE CODE
  Every task given to Antigravity/Gemini must be scoped to the smallest
  possible unit of work. Never ask for "build the full pipeline."
  Ask for one file, one function, one test at a time.

RULE 2 — REPORT BEFORE CONTINUING
  After every completed task, Antigravity/Gemini reports output back to Claude.
  Claude reviews. Only then does the next task begin.
  No autonomous multi-step execution without review checkpoints.

RULE 3 — NO SPECULATION IN CODE
  Antigravity/Gemini writes only what is specified. No "I also added X because
  it might be useful." Unrequested additions are rejected and rewritten.

RULE 4 — REUSE BEFORE REWRITE
  Before writing new code, check if existing code in the project can be
  extended. Never duplicate logic.

RULE 5 — TESTS ARE NOT OPTIONAL
  Every function must have a corresponding test. No exceptions.
  This prevents costly debugging sessions later.

RULE 6 — CONTEXT WINDOW HYGIENE
  When submitting tasks to Antigravity/Gemini, include ONLY the context
  needed for that specific task. Not the entire codebase.
  Reference CLAUDE.md sections by number (e.g., "See Section 6, D4").

RULE 7 — NO LIBRARY SPRAWL
  New Python packages require Claude approval before being added to
  requirements.txt. Every new dependency has a cost: security, maintenance,
  compatibility on M4.

RULE 8 — YAML CONFIG OVER HARDCODED VALUES
  No student names, language settings, paths, or model names in Python code.
  All configurable values live in config/*.yaml files.
```

---

## 9. TASK PROTOCOL — HOW ANTIGRAVITY/GEMINI RECEIVES WORK

### Task Request Format (Claude issues this)
```
TASK ID     : P1-D4
PHASE       : 1
DELIVERABLE : D4 — Ingest PDF into ChromaDB
CONTEXT     : See CLAUDE.md Section 6 (file structure) and Section 4 (stack)
SCOPE       : Write ONLY src/ingest/ingest_textbook.py
INPUT       : data/textbooks/cbse_english_grade1.pdf
OUTPUT      : Populated ChromaDB at data/chroma_db/
CONSTRAINTS :
  - Use LlamaIndex + ChromaDB only (Section 4)
  - Chunk size: 256 tokens, overlap: 32
  - Include metadata: chapter, page, subject, grade, board
  - Add docstring to every function
  - No hardcoded paths — read from config/curriculum_cbse_g1.yaml
DO NOT      : Build the RAG query layer (that is D5, separate task)
REPORT BACK : Paste the complete file + run output showing ChromaDB populated
```

### Task Report Format (Antigravity/Gemini returns this)
```
TASK ID     : P1-D4
STATUS      : COMPLETE / PARTIAL / BLOCKED
FILES CHANGED:
  - src/ingest/ingest_textbook.py (created, 87 lines)
  - config/curriculum_cbse_g1.yaml (modified — added db_path field)
PACKAGES ADDED: None
TEST OUTPUT :
  [paste actual terminal output here]
QUESTIONS   : [any blockers or decisions needed from Claude]
NEXT READY  : P1-D5 — RAG query pipeline
```

---

## 10. SECURITY & PRIVACY RULES

```
- No API keys, tokens, or secrets ever in code files
- All secrets in .env file (listed in .gitignore)
- .env.example contains key names only — no values
- Student data (session history, profile) never leaves Mac Mini M4
- No telemetry, no analytics, no external calls from student-facing code
- Camera feed is processed locally — never saved to disk unless explicitly enabled
- Parent reports are generated locally — stored in data/reports/ only
```

---

## 11. GIT DISCIPLINE

```
branch_strategy  : main (stable) + dev (active work)
commit_format    : [PHASE]-[TASK-ID]: Short description
                   Example: [P1-D4]: Add PDF ingestion pipeline
never_commit     : data/textbooks/, data/chroma_db/, .env, data/reports/
always_commit    : CLAUDE.md (update version + phase status on every change)
review_required  : Any merge to main requires Claude review of diff
```

---

## 12. KNOWN DECISIONS & RATIONALE (ADR LOG)

```
ADR-001 : Use Ollama for local LLM runtime
  Reason : Native Apple Silicon support, simple model switching, no server setup
  Date   : Project start

ADR-002 : Use LlamaIndex over LangChain for RAG
  Reason : Simpler RAG-specific API, better document handling, less abstraction overhead
  Date   : Project start

ADR-003 : SQLite for session memory (not a full vector DB)
  Reason : Lightweight, zero-config, sufficient for single-student use in Phase 1-5
  Date   : Project start

ADR-004 : Python 3.11+ required
  Reason : Best compatibility with all ML libraries on macOS Apple Silicon
  Date   : Project start

ADR-005 : Text-only interface for Phase 1
  Reason : Validate teaching quality before investing in voice/avatar/camera layers
  Date   : Project start
```

---

## 13. QUALITY STANDARDS — TEACHING RESPONSES

A teaching response passes quality review if it meets ALL of these:

```
[ ] Explains the concept — does not quote the textbook verbatim
[ ] Uses at least one age-appropriate analogy or real-world example
[ ] Language matches student age level (Grade 1 = simple, short sentences)
[ ] Ends with an encouraging question to check understanding
[ ] Does not introduce more than one new concept
[ ] Response length is appropriate (Grade 1: under 80 words)
[ ] Bilingual where appropriate (English main + Hindi support for Cristin)
[ ] Tone is warm, patient, and celebratory — never neutral or clinical
```

---

## 14. CHANGELOG

```
v1.0 | Initial version | All sections drafted | Phase 1 active
```

---
# END OF CLAUDE.md
# Next update due: After Phase 1, Deliverable D4 is complete
# Maintained by: Claude (claude.ai) — Project Architect
---
