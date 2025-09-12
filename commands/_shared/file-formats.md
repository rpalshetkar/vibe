# Common File Formats & Templates

## PRD Template

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

**Save as**: `[module]/docs/prd-[feature].md`

## Features Template

```markdown
# Features: [Product]

## Context
- Architecture: [Monolithic/Microservices/Hybrid]
- Stack: [Technologies]
- Constraints: [Key limitations]

## Priority 0 (MVP - Must Have)
- AU-LOGIN: User authentication [M]
  - Dependencies: None
  - Risk: Low
  - Notes: OAuth2 integration required

## Priority 1 (Should Have)  
- AU-2FA: Two-factor auth [S]
  - Dependencies: AU-LOGIN
  - Risk: Low
  - Notes: SMS and TOTP support

## Priority 2 (Nice to Have)
- PERF-CACHE: Advanced caching [XL]
  - Dependencies: All data features
  - Risk: High
  - Notes: Redis implementation

## Feature Dependencies Map
- AU-LOGIN → AU-2FA, UM-PROFILE
- DM-IMPORT → DM-EXPORT, RPT-GENERATE

## Implementation Order
1. AU-LOGIN (foundation)
2. DM-IMPORT (core functionality)
3. UM-PROFILE (user experience)
```

**Save as**: `[module]/docs/feat-[prd].md`

## Task List Template

```markdown
# Tasks: [Feature Name]

## Context & Decisions
- Architecture: [Approach]
- Testing: TDD with [framework]
- Standards: See `_shared/python-standards.md`
- Test Patterns: See `_shared/testing-standards.md`

## Time Estimation Guidelines
- **Solo**: Developer working independently
- **Claude**: Developer with AI assistance  
- **Simple [S]**: Solo: 15-45m | Claude: 10-20m
- **Medium [M]**: Solo: 45m-2h | Claude: 20m-1h
- **Complex [C]**: Solo: 2-4h | Claude: 1-2h

## Tasks

### Phase 1: [Phase Name]
- [ ] 1.0 [Parent Task] [Complexity]
  - [ ] 1.1 [Sub-task] [S] | Solo: 30m | Claude: 15m
  - [ ] 1.2 [Sub-task] [M] | Solo: 1h | Claude: 30m
  - [ ] 1.3 [Sub-task] [S] | Solo: 20m | Claude: 10m

### Phase 2: [Phase Name]  
- [ ] 2.0 [Parent Task] [Complexity]
  - [ ] 2.1 [Sub-task] [M] | Solo: 1.5h | Claude: 45m
  - [ ] 2.2 [Sub-task] [C] | Solo: 3h | Claude: 1.5h

## Dependencies
- Task 1.0 must complete before 2.0
- Phase 1 validates approach for Phase 2

## Testing Strategy
- All tasks follow TDD (RED-GREEN-REFACTOR)
- Use factory-boy for test data
- See `_shared/testing-standards.md` for patterns
```

**Save as**: `[module]/docs/tasks-[prd].md`

## Module Documentation Template

```markdown
# Module: [module_name]

## 📋 Overview
Brief description of what this module provides

## 🏗️ Architecture
How this module is structured internally

### Key Components
- **Component A**: Description (`path/to/file.py:123`)
- **Component B**: Description (`path/to/file.py:456`)

### Dependencies
- Uses: [other_module] for [purpose]
- Required by: [dependent_module]

## 🔌 Public API

### Functions
| Function | Description | Parameters | Returns | File |
|----------|-------------|------------|---------|------|
| func() | What it does | param: type | type | file.py:12 |

### Classes
| Class | Description | Key Methods | File |
|-------|-------------|------------|------|
| MyClass | Purpose | method1(), method2() | file.py:45 |

## 💡 Usage Examples

### Basic Usage
```python
# Example from tests or actual usage
from module import function
result = function(data)
```

## 🧪 Testing
```bash
# How to test this module
pytest tests/test_module.py
```

## 📝 Recent Changes
- Updated function names from refactoring
- Added new API endpoints

## ⚠️ Known Issues
- Any deprecations or pending changes
```

**Save as**: `[module]/docs/README.md`

## Analysis Template

```markdown
# Analysis: [Problem]

## Problem Understanding
- Core challenge
- Key constraints
- Success criteria

## Considered Approaches
### Option 1: [Name]
- **Pros**: ...
- **Cons**: ...
- **Complexity**: S/M/L

### Option 2: [Name]
- **Pros**: ...
- **Cons**: ...
- **Complexity**: S/M/L

## Recommendation
[Chosen approach with rationale]

## Implementation Plan
1. High-level steps
2. Key decisions needed
3. Risk mitigations

## Open Questions
- Items needing clarification
```

**Save as**: `vibe/analysis-[topic].md`

## Feature Acronym Standards

Use meaningful, consistent prefixes:
- `AU` - Authentication & Authorization
- `UM` - User Management  
- `DM` - Data Management
- `API` - Integration & APIs
- `SYS` - System Core
- `SEC` - Security
- `PERF` - Performance
- `UI` - User Interface
- `RPT` - Reporting
- `NTF` - Notifications

## Complexity Indicators

- **[S]imple**: 15-45 minutes, minimal complexity
- **[M]edium**: 45 minutes to 2 hours, moderate complexity
- **[C]omplex**: 2-4 hours, high complexity  
- **[XL]**: 4+ hours, very high complexity

## Risk Levels

- **Low**: Well-understood, minimal dependencies
- **Medium**: Some unknowns or moderate dependencies
- **High**: Significant unknowns or complex dependencies
- **Critical**: Blockers or architectural risks

## File Organization Rules

### VIBE Documentation Structure
```
project/
├── README.md           # Project root overview
├── [module]/           # Module folder
│   ├── docs/           # Per-module documentation
│   │   ├── README.md   # Module overview
│   │   ├── prd-*.md    # Product requirements
│   │   ├── feat-*.md # Feature specifications
│   │   ├── tasks-*.md  # Implementation tasks
│   │   └── API.md      # API documentation
│   └── [module code files]
└── [other modules]/
```

### Analysis Files
```
vibe/
└── analysis-*.md       # Deep thinking outputs
```

### Standards Reference
All VIBE commands reference:
- `_shared/python-standards.md` for Python requirements
- `_shared/testing-standards.md` for testing patterns
- `_shared/file-formats.md` for output templates