# MY MENTOR — TASK LOG & WALKTHROUGH RECORD
# Version: 1.0 | Phase: 1
# Submit this to Claude after every task for review.
# Claude reviews ALL completed work before the next task is issued.
# ─────────────────────────────────────────────────────────────────────────────

## HOW TO USE THIS LOG

1. Claude issues a task → you paste it under "Task Issued"
2. You run Antigravity/Gemini with the Master Prompt + task
3. Paste the complete output under "Task Output"
4. Submit this log to Claude in your next message
5. Claude reviews, approves or flags issues, issues next task

Keep every entry. This log is the project's audit trail.

---

## TASK LOG ENTRIES

---

### ENTRY 001

**Date:** ___________
**Phase:** 1
**Task ID:** P1-D1

**Task Issued by Claude:**
```
TASK ID     : P1-D1
PHASE       : 1
DELIVERABLE : D1 — Verify Ollama installed and running on Mac Mini M4
SCOPE       : Terminal commands only — no code files
STEPS       :
  1. Run: ollama --version
  2. Run: ollama list
  3. Run: ollama pull llama3.1:8b
  4. Run: ollama run llama3.1:8b "Explain the letter A to a 6-year-old in 2 sentences."
  5. Paste all terminal output exactly as shown
DO NOT      : Install anything else. One model only for now.
REPORT BACK : Full terminal output from all 4 commands
```

**Output from Antigravity/Gemini:**
```
[PASTE COMPLETE OUTPUT HERE]
```

**Claude Review:**
```
[ ] Approved — proceed to next task
[ ] Issue found — [describe]
[ ] Question — [describe]
```

**Notes:**
___________________________________________________________________________

---

### ENTRY 002

**Date:** ___________
**Phase:** 1
**Task ID:** P1-D2

**Task Issued by Claude:**
```
[Claude will fill this in after Entry 001 is reviewed]
```

**Output from Antigravity/Gemini:**
```
[PASTE COMPLETE OUTPUT HERE]
```

**Claude Review:**
```
[ ] Approved — proceed to next task
[ ] Issue found — [describe]
[ ] Question — [describe]
```

**Notes:**
___________________________________________________________________________

---

### ENTRY 003

**Date:** ___________
**Phase:** 1
**Task ID:** P1-D3

**Task Issued by Claude:**
```
[Claude will fill this in after Entry 002 is reviewed]
```

**Output from Antigravity/Gemini:**
```
[PASTE COMPLETE OUTPUT HERE]
```

**Claude Review:**
```
[ ] Approved — proceed to next task
[ ] Issue found — [describe]
[ ] Question — [describe]
```

**Notes:**
___________________________________________________________________________

---

### ENTRY 004

**Date:** ___________
**Phase:** 1
**Task ID:** P1-D4

**Task Issued by Claude:**
```
TASK ID     : P1-D4
PHASE       : 1
DELIVERABLE : D4 — Ingest Grade 1 CBSE English PDF into ChromaDB
CONTEXT     : See CLAUDE.md Section 6 (file structure) and Section 4 (stack)
SCOPE       : Write ONLY src/ingest/ingest_textbook.py
INPUT       : data/textbooks/cbse_english_grade1.pdf
OUTPUT      : Populated ChromaDB at data/chroma_db/
CONSTRAINTS :
  - Use LlamaIndex + ChromaDB only
  - Chunk size: 256 tokens, overlap: 32
  - Metadata per chunk: chapter, page_number, subject, grade, board
  - No hardcoded paths — read all paths from config/curriculum_cbse_g1.yaml
  - Type hints on all functions
  - Docstring on every function
  - Use logging not print statements
PACKAGES    : llama-index, chromadb (already approved)
DO NOT      : Build the RAG query layer — that is D5
REPORT BACK : Complete file + terminal output showing ChromaDB populated
```

**Output from Antigravity/Gemini:**
```
[PASTE COMPLETE OUTPUT HERE]
```

**Claude Review:**
```
[ ] Approved — proceed to next task
[ ] Issue found — [describe]
[ ] Question — [describe]
```

**Notes:**
___________________________________________________________________________

---

### ENTRY 005

**Date:** ___________
**Phase:** 1
**Task ID:** P1-D5

**Task Issued by Claude:**
```
[Claude will fill this in after Entry 004 is reviewed]
```

**Output from Antigravity/Gemini:**
```
[PASTE COMPLETE OUTPUT HERE]
```

**Claude Review:**
```
[ ] Approved — proceed to next task
[ ] Issue found — [describe]
[ ] Question — [describe]
```

**Notes:**
___________________________________________________________________________

---

## PHASE 1 COMPLETION CHECKLIST

```
[ ] D1  — Ollama installed, LLaMA 3.1 8B running on Mac Mini M4
[ ] D2  — LLaMA 3.1 8B response quality: PASS / FAIL
[ ] D3  — Qwen 2.5 7B response quality: PASS / FAIL
[ ] D4  — Grade 1 CBSE English PDF ingested into ChromaDB
[ ] D5  — RAG pipeline: 10 questions answered correctly from textbook
[ ] D6  — Grade 1 Cristin system prompt: tested and approved by Claude
[ ] D7  — Hindi support tested with Qwen
[ ] D8  — mcp-curriculum MCP server: built and tested
[ ] D9  — CLI interface: working end-to-end
[ ] D10 — Quality review: 20 questions, human-reviewed (PASS threshold: 18/20)

PHASE 1 STATUS: [ ] COMPLETE — approved by Claude to begin Phase 2
```

---

## ISSUE TRACKER

| Issue ID | Task | Description | Status | Resolution |
|----------|------|-------------|--------|------------|
| — | — | No issues logged yet | — | — |

---

## DECISIONS LOG

| Decision | Task | Options Considered | Choice Made | Approved By |
|----------|------|--------------------|-------------|-------------|
| — | — | — | — | — |

---

## TOKEN USAGE TRACKER

| Session | Tool Used | Task ID | Approx Tokens Used | Notes |
|---------|-----------|---------|--------------------|-------|
| 001 | — | — | — | — |

---
# END OF TASK LOG
# ─────────────────────────────────────────────────────────────────────────────
