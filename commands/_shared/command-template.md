# Command Template Structure

## Standard Command Format

All VIBE commands should follow this consistent structure:

```markdown
# [xcommand] - [Brief Purpose Statement]

## Purpose
[1-2 sentences describing what this command does]

## Process

### 1. [Phase Name]
[Description of what happens in this phase]
- [Key activity or step]
- [Key activity or step]
- [Key activity or step]

### 2. [Phase Name]  
[Description of next phase]
- [Key activity or step]
- [Key activity or step]

### 3. [Phase Name]
[Final phase description]
- [Key activity or step]
- [Key activity or step]

## [Section Name] (if applicable)
[Additional process details, examples, or configuration]

## Key Principles
- [Core principle 1]
- [Core principle 2] 
- [Core principle 3]
- [Reference to shared standards when applicable]

## Output
[What files/artifacts this command creates]

## Temporary File Management
All commands must use the project sandbox for temporary files:
- **Analysis outputs**: `sandbox/analysis/[topic].md` 
- **Temporary files**: `sandbox/temp/[operation].md`
- **Work-in-progress**: `sandbox/drafts/[document].md`
- **Never create temporary files** in main project directories

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`
```

## File Size Guidelines

### Target Sizes
- **Simple commands**: 1-2KB (xprd, xthink)
- **Standard commands**: 2-4KB (xspec, xgo, xpyfix)
- **Complex commands**: 4-5KB maximum (xtasks, xdoc)

### Content Guidelines
- **Purpose**: 1-2 sentences maximum
- **Process**: 3-5 phases maximum
- **Examples**: Essential patterns only
- **References**: Link to shared standards instead of duplicating

## Consistency Requirements

### Terminology Standards
- **PRD**: Product Requirements Document
- **Features**: Feature specifications from PRD
- **Tasks**: Implementation task lists
- **Module**: Code organization unit
- **Factory-boy**: Test data generation (not "fixtures")
- **TDD**: Test-Driven Development (RED-GREEN-REFACTOR)

### File Path Standards
- **VIBE docs**: `claudify/[module]/[type]-[name].md`
- **Analysis files**: `vibe/analysis-[topic].md`
- **Standards**: `_shared/[standard-name].md`

### Process Phase Naming
- Use numbered phases (1. 2. 3.) for sequential steps
- Use descriptive names for each phase
- Keep phase descriptions to 2-3 lines maximum
- Include key activities as bullet points

## Shared Standards Integration

### When to Reference Shared Standards
- **Always reference** for Python requirements, testing patterns, file formats
- **Never duplicate** information available in shared standards
- **Use links** like `See _shared/python-standards.md for...`

### Required References
All commands should include this footer:
```markdown
## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`  
- File Formats: `_shared/file-formats.md`
```

## Command-Specific Sections

### Workflow Commands (xprd, xspec, xtasks, xgo)
Include:
- Interactive questioning patterns
- User confirmation points
- Output file specifications
- Dependencies between commands

### Tool Commands (xpyfix, xpyinit, xtests)
Include:
- Command sequences
- Configuration requirements
- Quality check procedures
- Error handling approaches

### Analysis Commands (xthink, xdoc)
Include:
- Analysis methodologies
- Output formats
- Decision frameworks
- Validation approaches

## Anti-Patterns to Avoid

### ❌ Don't Do This
- Duplicate Python standards across commands
- Include full configuration files in command docs
- Write commands longer than 5KB
- Use inconsistent terminology
- Skip phase organization
- Include excessive examples

### ✅ Do This Instead
- Reference shared standards documents
- Link to configuration templates
- Keep commands focused and concise
- Use standard VIBE terminology
- Organize content in clear phases
- Include only essential examples

## Quality Checklist

Before finalizing any command:
- [ ] Follows template structure
- [ ] Under size guidelines (1-5KB)
- [ ] References shared standards appropriately
- [ ] Uses consistent VIBE terminology
- [ ] Includes clear phases/process
- [ ] Has proper output specifications
- [ ] Contains essential examples only
- [ ] Links to related commands when relevant