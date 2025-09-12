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

### 3. Feature Naming
Use feature acronyms from `_shared/vibe-standards.md`

### 4. Interactive Validation
Present extracted features for review:
- "Does this feature breakdown make sense?"
- "Any missing critical features?"
- "Is the prioritization correct?"
- "Should any features be re-scoped?"

## Output
Use Features template from `_shared/file-formats.md`
Save following naming standards in `_shared/vibe-standards.md`

## Key Principles
- Challenge assumptions constructively
- Identify hidden complexities early
- Consider technical debt implications
- Balance ideal vs pragmatic solutions
- Keep descriptions concise (<60 chars)
- Focus on WHAT, not HOW

## Standards & References
- **File Formats**: `_shared/file-formats.md` - All document templates
- **VIBE Standards**: `_shared/vibe-standards.md` - Naming and organization
- **Python Standards**: `_shared/python-standards.md` - Code quality requirements
- **Testing Standards**: `_shared/testing-standards.md` - Testing patterns and TDD