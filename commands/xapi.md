# xapi - API Naming & Consistency Review

## Purpose
Analyze codebase ClassNames, functions, and public APIs across modules for naming consistency and muscle memory optimization.

## Process

### 1. Codebase Analysis
- Scan project modules for classes, functions, and public APIs
- Identify naming patterns and inconsistencies across modules
- Map API surface area and usage patterns
- Document current naming conventions

### 2. /xthink Analysis Mode
Apply extended thinking to:
- Evaluate naming consistency within and across modules
- Identify cognitive load and muscle memory issues
- Consider semantic groupings and developer ergonomics
- Assess discoverability and intuitive naming patterns

### 3. Naming Optimization
- Generate crisp, short, intuitive name suggestions
- Focus on muscle memory and typing efficiency
- Ensure semantic clarity and consistent patterns
- Consider cross-module API coherence

### 4. Migration Planning
- Create actionable renaming recommendations
- Provide backward compatibility strategies
- Estimate refactoring effort and risks
- Document migration timeline and approach

## Key Principles
- **Muscle Memory First**: Names should be easy to type and remember
- **Semantic Clarity**: Purpose should be obvious from the name
- **Cross-Module Consistency**: Similar concepts use similar naming
- **Developer Ergonomics**: Optimize for daily usage patterns
- **Migration Awareness**: Consider existing usage and compatibility

## Output
Creates `docs/api-review.md` with comprehensive analysis and actionable recommendations

## Standards & References
- **File Formats**: `_shared/file-formats.md` - All document templates
- **VIBE Standards**: `_shared/vibe-standards.md` - Naming and organization
- **Python Standards**: `_shared/python-standards.md` - Code quality requirements
- **Testing Standards**: `_shared/testing-standards.md` - Testing patterns and TDD