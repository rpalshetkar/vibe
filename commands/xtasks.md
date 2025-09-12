# xtasks - Task List Generator

## Purpose
Generate actionable task lists from PRD/Features through deep analysis and interactive planning with TDD approach.

## Process

### 1. Deep Thinking & Analysis
Enter extended thinking mode to:
- Analyze PRD requirements holistically
- Map feature dependencies and interactions
- Identify architectural patterns and opportunities
- Consider performance, security, and scalability implications
- Evaluate multiple implementation approaches
- Assess technical debt and future maintainability
- Plan test scenarios before implementation

### 2. Interactive Discovery Session

**Architecture Questions**
- "What's your current folder structure and naming conventions?"
- "Do you prefer feature-based or layer-based organization?"
- "Any existing patterns I should follow for this feature?"
- "What's your testing strategy (unit/integration/e2e)?"
- "Should we use factory-boy for test data generation?"

**Implementation Strategy**
- "Should we build this incrementally or all at once?"
- "Any performance benchmarks to meet?"
- "What error handling patterns do you use?"
- "Preferred state management approach?"
- "Any third-party libraries to leverage or avoid?"

**Demo & CLI Requirements**
- "What scenarios should the exhaustive demo cover?"
- "Which CLI commands would be most useful (keep them short)?"
- "Should CLI commands follow existing patterns in your codebase?"

**Risk Assessment**
- "What's the riskiest part of this implementation?"
- "What could break existing functionality?"
- "Timeline constraints or deadlines?"

### 3. Parent Task Generation
After thorough analysis:
1. **Generate 5-10 parent tasks** with complexity [S/M/C]
2. **Always include these mandatory tasks**:
   - Exhaustive demo implementation in `examples/demo_{module}.py`
   - CLI interface in `{module}/cli.py` with short, useful commands
3. **Present with rationale**: Explain why tasks are structured this way
4. **Seek feedback**: "Does this breakdown align with your expectations?"
5. **Refine based on input**: Adjust before proceeding

### 4. Sub-task Breakdown with TDD
Once parent tasks approved:
1. **Detail each parent** into 15-60 minute sub-tasks
2. **Tests ALWAYS come first** - every code task starts with test writing
   - Create test factories with factory-boy before writing tests
   - Define reusable fixtures in `tests/factories/`
   - Avoid hardcoding test data in test files
3. **Mark complexity** [S/M/C] for each
4. **Add time estimates** for both Solo and Claude Code:
   - Solo: Developer working independently
   - Claude Code: Developer with AI assistance
5. **Note dependencies** between sub-tasks
6. **Follow RED-GREEN-REFACTOR** cycle explicitly

## Output
Use Tasks template from `_shared/file-formats.md`
Save following naming standards in `_shared/vibe-standards.md`

## Key Principles
- Use deep thinking for complex analysis
- Ask focused questions, not overwhelming lists
- Tests always come first (TDD is mandatory)
- Demo and CLI are not optional - they're mandatory deliverables
- Factory-boy for all test data generation
- Interactive confirmation at key decision points
- RED-GREEN-REFACTOR cycle religiously
- Time estimates help with planning and expectations

## Interactive Decision Points
1. **Task Structure**: "Does this breakdown align with your expectations?"
2. **Architecture**: "Should we use [approach] for this feature?"
3. **Testing Strategy**: "Does this test approach make sense?"
4. **Demo Planning**: "What scenarios should the exhaustive demo cover?"
5. **CLI Design**: "Which commands would be most useful? Keep them short!"

## Standards & References
- **File Formats**: `_shared/file-formats.md` - All document templates
- **VIBE Standards**: `_shared/vibe-standards.md` - Naming and organization
- **Python Standards**: `_shared/python-standards.md` - Code quality requirements
- **Testing Standards**: `_shared/testing-standards.md` - Testing patterns and TDD