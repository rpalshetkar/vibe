# xprd - Product Requirements Document Generator

## Purpose
Create structured PRDs through intelligent questioning and analysis.

## Process

### 1. Context Gathering
Ask 3-5 focused questions per batch, progressing from broad to specific:
- **Problem & Users**: Core problem, target audience, success vision
- **Features & Scope**: Key functionality, user stories, boundaries  
- **Implementation**: Technical needs, timeline, success metrics

### 2. PRD Structure
```markdown
# PRD: [Feature Name]

## Overview
Problem statement and solution approach

## Goals
- Specific, measurable objectives

## User Stories
As a [user], I want [action] so that [benefit]

## Requirements
1. [REQ-001] Description
2. [REQ-002] Description

## Out of Scope
- What this will NOT include

## Success Metrics
- Measurable outcomes

## Open Questions
- Unresolved items
```

### 3. Output
Save as `claudify/[module]/prd-[feature].md`
- Create module folder under claudify if it doesn't exist
- All module-related PRDs, specs, and tasks go in this folder

## Key Principles
- Ask one question at a time, not complex lists
- Target junior developer comprehension
- Be explicit and unambiguous
- Focus on WHAT, not HOW

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`