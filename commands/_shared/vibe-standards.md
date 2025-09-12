# VIBE Standards & Conventions

## File Naming Standards

### Document Types & Prefixes
- **PRD**: `prd-[feature-name].md` - Product Requirements Documents
- **Features**: `feat-[prd-name].md` - Feature specifications extracted from PRDs
- **Tasks**: `tasks-[prd-name].md` - Implementation task lists
- **Analysis**: `analysis-[topic].md` - Deep thinking outputs
- **Module Docs**: `README.md` - Module overview and architecture
- **API Docs**: `API.md` - Public API reference (when applicable)

### File Organization Structure
```
project/
├── README.md                    # Project root overview
├── [module]/                    # Module folder
│   ├── docs/                   # Per-module documentation
│   │   ├── README.md           # Module overview
│   │   ├── prd-*.md            # Product requirements
│   │   ├── feat-*.md           # Feature specifications
│   │   ├── tasks-*.md          # Implementation tasks
│   │   └── API.md              # API documentation (optional)
│   └── [module code files]
├── [other modules]/
└── sandbox/                     # Temporary analysis files
    ├── analysis/               # Deep thinking outputs
    ├── temp/                   # Work-in-progress
    └── drafts/                 # Document drafts
```

## Feature Naming Conventions

### Feature Acronym Standards
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

### Complexity Indicators
- **[S]imple**: 15-45 minutes, minimal complexity
- **[M]edium**: 45 minutes to 2 hours, moderate complexity
- **[C]omplex**: 2-4 hours, high complexity  
- **[XL]**: 4+ hours, very high complexity

### Risk Levels
- **Low**: Well-understood, minimal dependencies
- **Medium**: Some unknowns or moderate dependencies
- **High**: Significant unknowns or complex dependencies
- **Critical**: Blockers or architectural risks

## Command Standards

### Interactive Patterns
- **Ask focused questions**: 3-5 questions per batch, not overwhelming lists
- **Progress from broad to specific**: Problem → Features → Implementation
- **Get user confirmation**: At key decision points
- **Present for review**: Show extracted information for validation

### Output Standards
- **Reference shared templates**: Always use `_shared/file-formats.md`
- **Save location**: Follow `[module]/docs/[type]-[name].md` pattern
- **Document titles**: Use descriptive titles with product/feature names
- **File size limits**: 1-5KB per command file

### Quality Principles
- **One concept per command**: Clear, focused purpose
- **Phase organization**: Structure process in numbered phases
- **Reference don't duplicate**: Link to shared standards
- **Essential examples only**: Avoid excessive duplication
- **Consistent terminology**: Use standard VIBE vocabulary

## Reference Pattern

All commands should include this standard footer:
```markdown
## Standards & References
- **File Formats**: `_shared/file-formats.md` - All document templates
- **VIBE Standards**: `_shared/vibe-standards.md` - Naming and organization
- **Python Standards**: `_shared/python-standards.md` - Code quality requirements
- **Testing Standards**: `_shared/testing-standards.md` - Testing patterns and TDD
```

## Anti-Patterns to Avoid

### ❌ Don't Do This
- Duplicate templates across command files
- Include full document structures in commands
- Use inconsistent file naming
- Write commands longer than 5KB
- Skip references to shared standards

### ✅ Do This Instead
- Reference `_shared/file-formats.md` for all templates
- Link to `_shared/vibe-standards.md` for naming conventions
- Keep commands focused on process, not format
- Use consistent terminology throughout
- Always include standard footer references