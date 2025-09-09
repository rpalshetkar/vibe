# xspec - Feature Specification Extractor

## Purpose
Extract and refine feature list from PRD through interactive consultation and analysis.

## Process

### 1. Interactive Planning Session
Before extracting features, engage in comprehensive consultation:

**Initial Analysis**
- Review PRD thoroughly
- Identify ambiguous requirements
- Note potential feature dependencies

**Feature Discovery Questions**
- "Which features are absolutely critical for MVP?"
- "Are there hidden dependencies between features?"
- "What features could be combined or split?"
- "Which features have the highest user impact?"
- "What technical constraints affect feature priority?"

**Architecture Consultation**
- "Should we use microservices or monolithic approach?"
- "What's the preferred data storage strategy?"
- "Any existing systems to integrate with?"
- "Performance requirements per feature?"
- "Security considerations for each feature?"

**Implementation Strategy**
- "Preferred technology stack for each feature?"
- "Any features that should be third-party services?"
- "Which features need real-time capabilities?"
- "Scalability requirements per feature?"

### 2. Feature Extraction & Refinement
After consultation, extract features with:
- Clear boundaries and scope
- Identified dependencies
- Risk assessment
- Effort estimation [S/M/L/XL]

### 3. Feature Acronyms
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

### 4. Interactive Validation
Present extracted features for review:
- "Does this feature breakdown make sense?"
- "Any missing critical features?"
- "Is the prioritization correct?"
- "Should any features be re-scoped?"

## Output Format
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
  
- DM-IMPORT: CSV/JSON import [L]
  - Dependencies: AU-LOGIN
  - Risk: Medium
  - Notes: 10MB file size limit

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

Save as `claudify/[module]/features-[prd].md`

## Key Principles
- Challenge assumptions constructively
- Identify hidden complexities early
- Consider technical debt implications
- Balance ideal vs pragmatic solutions
- Keep descriptions concise (<60 chars)
- Focus on WHAT, not HOW

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`