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

## Output Format

```markdown
# Tasks: [Feature Name]

## Time Estimation Guidelines
- **Solo**: Developer working independently
- **Claude**: Developer using Claude Code
- **Simple [S]**: Solo: 15-45m | Claude: 10-20m
- **Medium [M]**: Solo: 45m-2h | Claude: 20m-1h  
- **Complex [C]**: Solo: 2-4h | Claude: 1-2h

## Context & Decisions
- Architecture: [Approach]
- Testing: TDD with [framework] - tests first, always
- Test Data: factory-boy for fixture generation
- Standards: See `_shared/python-standards.md`
- Test Patterns: See `_shared/testing-standards.md`

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

### Phase 3: Demo & CLI Implementation (MANDATORY)
- [ ] 3.0 Create exhaustive demo [M]
  - [ ] 3.1 Write demo tests first [S]
  - [ ] 3.2 Implement comprehensive usage examples [M]
  - [ ] 3.3 Cover error handling scenarios [S]

- [ ] 4.0 Build CLI interface [M]
  - [ ] 4.1 Write CLI tests first [S]
  - [ ] 4.2 Design short, memorable commands [S]
  - [ ] 4.3 Implement core CLI functionality [M]

## Dependencies
- Task 1.0 must complete before 2.0
- Demo and CLI are mandatory deliverables

## TDD Cycle for Each Task
1. **RED**: Write failing test first
2. **GREEN**: Write minimal code to pass
3. **REFACTOR**: Clean up, optimize, simplify names
```

**Save as**: `claudify/[module]/tasks-[prd].md`

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

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`