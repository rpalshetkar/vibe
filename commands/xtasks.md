# xtasks - Task List Generator

## Purpose
Generate actionable task lists from PRD/Features through deep analysis and interactive planning with TDD approach.

## Process

### Phase 0: Deep Thinking & Analysis
**Enter extended thinking mode to:**
- Analyze PRD requirements holistically
- Map feature dependencies and interactions
- Identify architectural patterns and anti-patterns
- Consider performance, security, and scalability implications
- Evaluate multiple implementation approaches
- Assess technical debt and future maintainability
- Plan test scenarios before implementation
- **Identify protocol/plugin opportunities**

### Phase 1: Interactive Discovery Session

**Architecture Questions**
- "What's your current folder structure and naming conventions?"
- "Do you prefer feature-based or layer-based organization?"
- "Any existing patterns I should follow for this feature?"
- "What's your testing strategy (unit/integration/e2e)?"
- "Preferred test framework and assertion style?"
- "Should we use factory-boy for test data generation?"
- "Where should test factories be located (tests/factories/)?"

**Protocol/Plugin Strategy** (if applicable)
- "I see potential for protocol-based architecture. Should we design this way?"
- "What behaviors must ALL implementations guarantee (protocol)?"
- "Which plugin should we build first as the reference?"
- "What makes the most sense as the 'simplest complete example'?"
- "Once the first plugin is done, can others be built in parallel?"
- "Any protocol methods that are optional vs required?"
- "Should we use interface, abstract class, or both for the protocol?"

**Naming Conventions**
- "Any naming standards for functions/classes?"
- "Preferred abbreviations or acronyms?"
- "Examples of good names from existing code?"
- "Max length preferences for identifiers?"

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
- "Any specific CLI framework preference (argparse, click, typer)?"

**Risk Assessment**
- "What's the riskiest part of this implementation?"
- "Any regulatory or compliance requirements?"
- "What could break existing functionality?"
- "Timeline constraints or deadlines?"

**Technical Decisions**
- "Database schema preferences (normalized vs denormalized)?"
- "Caching strategy for this feature?"
- "API versioning approach?"
- "Authentication/authorization requirements?"

### Phase 2: Parent Task Generation
After thorough analysis:
1. **Generate 5-10 parent tasks** with complexity [Simple/Medium/Complex]
2. **Identify protocol/plugin opportunities**: Mark tasks that follow same protocol
3. **Always include these mandatory tasks**:
   - Exhaustive demo implementation in `examples/demo_{module}.py`
   - CLI interface in `{module}/cli.py` with short, useful commands
4. **Present with rationale**: Explain why tasks are structured this way
5. **Seek feedback**: "Does this breakdown align with your expectations?"
6. **Refine based on input**: Adjust before proceeding

### Phase 3: Sub-task Breakdown with TDD
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
7. **Flag parallel opportunities** after first plugin is done

## Output Format for Protocol/Plugin Pattern
```markdown
# Tasks: [Feature Name]

## Time Estimation Guidelines
- **Solo**: Developer working independently without AI assistance
- **Claude**: Developer using Claude Code for pair programming
- Time format: [Solo: Xh Ym | Claude: Xh Ym]
- Claude estimates typically 40-60% of Solo time due to:
  - Instant code generation and refactoring
  - Pattern recognition and best practices
  - Automated test writing
  - Real-time error detection

### Complexity Time Ranges
- **Simple [S]**: Solo: 15-45m | Claude: 10-20m
- **Medium [M]**: Solo: 45m-2h | Claude: 20m-1h  
- **Complex [C]**: Solo: 2-4h | Claude: 1-2h
  
## Context & Decisions
- Architecture: Protocol-based with plugin implementations
- Protocol Design: [Interface/Abstract class/Both]
- Reference Plugin: [Chosen first implementation]
- Parallel Plugins: [Other implementations after reference]
- Key Patterns: [Patterns to follow]
- Naming: [Conventions - prefer short, clear names]
- Testing: TDD with [framework] - tests first, always
- Test Data: factory-boy for fixture generation

## Protocol/Plugin Architecture Decision
After analysis, identified protocol-based architecture opportunity:

**Protocols Identified:**
- **StorageProtocol**: save(), load(), delete(), exists()
- **AuthProtocol**: login(), logout(), verify(), refresh()
- **ExportProtocol**: format(), validate(), export()

**Plugin Implementations:**
- **Storage**: FileStorage, S3Storage, DBStorage, RedisStorage
- **Auth**: LocalAuth, OAuthAuth, SAMLAuth, LDAPAuth  
- **Export**: JSONExport, CSVExport, XMLExport, PDFExport

**Recommended Approach:**
1. Define StorageProtocol with contract tests
2. Build **FileStorage** plugin first (simplest, no dependencies)
3. Validate protocol completeness with first plugin
4. Then parallelize: S3Storage, DBStorage, RedisStorage

**User Confirmation Required:**
"Does this protocol definition capture all required behaviors?"
"Should we proceed with FileStorage as reference plugin?"
"After FileStorage validates the protocol, can others be built in parallel?"

## Naming Guidelines
- Protocols: `StorageProtocol`, `AuthProtocol` (explicit suffix)
- Plugins: `FileStorage`, `S3Storage` (descriptive, no suffix)
- Methods: `save()`, `load()`, `delete()` (crisp verbs)
- Keep it clear: protocol defines contract, plugin implements it

## File Structure (Protocol/Plugin Pattern)
```
project/
├── src/
│   ├── protocols/
│   │   ├── StorageProtocol.ts [NEW - defines contract]
│   │   ├── StorageProtocol.test.ts [NEW - contract tests ALL plugins must pass]
│   │   ├── AuthProtocol.ts [NEW - defines contract]
│   │   ├── AuthProtocol.test.ts [NEW - contract tests]
│   │   └── ExportProtocol.ts [NEW - defines contract]
│   ├── plugins/
│   │   ├── storage/
│   │   │   ├── FileStorage.ts [NEW - reference plugin]
│   │   │   ├── FileStorage.test.ts [NEW - write first]
│   │   │   ├── S3Storage.ts [NEW - after FileStorage]
│   │   │   ├── S3Storage.test.ts [NEW - write first]
│   │   │   ├── DBStorage.ts [NEW - after FileStorage]
│   │   │   └── DBStorage.test.ts [NEW - write first]
│   │   ├── auth/
│   │   │   ├── LocalAuth.ts [NEW - reference plugin]
│   │   │   ├── LocalAuth.test.ts [NEW - write first]
│   │   │   ├── OAuthAuth.ts [NEW - parallel after LocalAuth]
│   │   │   └── OAuthAuth.test.ts [NEW - write first]
│   │   └── export/
│   │       ├── JSONExport.ts [NEW - reference plugin]
│   │       └── JSONExport.test.ts [NEW - write first]
│   ├── registry/
│   │   ├── PluginRegistry.ts [NEW - manages plugins]
│   │   └── PluginRegistry.test.ts [NEW - write first]
│   ├── {module}/
│   │   └── cli.py [NEW - CLI interface with short, useful commands]
│   └── tests/
│       └── factories/ [NEW - factory-boy test data]
│           ├── __init__.py
│           ├── storage_factory.py
│           ├── auth_factory.py
│           └── export_factory.py
├── examples/
│   └── demo_{module}.py [NEW - exhaustive demo showing all features]
```

## Tasks with Protocol/Plugin Pattern

### Phase 1: Protocol Definition & Contract Tests
- [ ] 1.0 Design StorageProtocol [Complex] 
  - [ ] 1.1 Define required methods (save, load, delete, exists) [Simple]
  - [ ] 1.2 Define optional methods (bulk operations) [Simple]
  - [ ] 1.3 Write comprehensive contract tests [Complex]
  - [ ] 1.4 Define error handling requirements [Medium]
  - [ ] 1.5 Document protocol specifications [Simple]
  - [ ] 1.6 Create protocol compliance validator [Medium]

**DECISION POINT**: "Is this protocol complete? Any missing behaviors?"

### Phase 2: Reference Plugin Implementation
- [ ] 2.0 Build FileStorage plugin (REFERENCE) [Medium]
  - [ ] 2.1 Create test factories for storage data [Simple]
  - [ ] 2.2 Write FileStorage-specific tests using factories [Medium]
  - [ ] 2.3 Implement required protocol methods [Medium]
  - [ ] 2.4 Ensure ALL contract tests pass [Simple]
  - [ ] 2.5 Implement optional protocol methods [Simple]
  - [ ] 2.6 Add FileStorage-specific features [Simple]
  - [ ] 2.7 Write integration tests with factory data [Simple]
  - [ ] 2.8 Document plugin development guide [Simple]

**CHECKPOINT: Protocol Validation**
- Does FileStorage fully implement the protocol?
- Are contract tests comprehensive enough?
- Any protocol changes needed based on implementation?
- Ready to parallelize other plugins?

### Phase 3: Parallel Plugin Development
*After FileStorage is approved and protocol is validated:*

- [ ] 3.0 Build S3Storage plugin [Medium] [PARALLEL]
  - [ ] 3.1 Create S3-specific test factories [Simple]
  - [ ] 3.2 Write S3Storage-specific tests using factories [Medium]
  - [ ] 3.3 Implement required protocol methods [Medium]
  - [ ] 3.4 Ensure ALL contract tests pass [Simple]
  - [ ] 3.5 Add S3-specific features (multipart, presigned) [Medium]
  - [ ] 3.6 Update documentation [Simple]

- [ ] 4.0 Build DBStorage plugin [Complex] [PARALLEL]
  - [ ] 4.1 Create DB-specific test factories [Simple]
  - [ ] 4.2 Write DBStorage-specific tests using factories [Medium]
  - [ ] 4.3 Implement required protocol methods [Complex]
  - [ ] 4.4 Ensure ALL contract tests pass [Simple]
  - [ ] 4.5 Add DB-specific features (transactions) [Medium]
  - [ ] 4.6 Update documentation [Simple]

- [ ] 5.0 Build RedisStorage plugin [Medium] [PARALLEL]
  - [ ] 5.1 Create Redis-specific test factories [Simple]
  - [ ] 5.2 Write RedisStorage-specific tests using factories [Medium]
  - [ ] 5.3 Implement required protocol methods [Medium]
  - [ ] 5.4 Ensure ALL contract tests pass [Simple]
  - [ ] 5.5 Add Redis-specific features (TTL, pub/sub) [Simple]
  - [ ] 5.6 Update documentation [Simple]

### Phase 4: Plugin Registry & Integration
- [ ] 6.0 Build plugin management system [Medium]
  - [ ] 6.1 Write registry tests [Medium]
  - [ ] 6.2 Create PluginRegistry class [Medium]
  - [ ] 6.3 Implement plugin discovery [Simple]
  - [ ] 6.4 Add plugin switching logic [Medium]
  - [ ] 6.5 Write integration tests [Medium]
  - [ ] 6.6 Performance benchmarks [Simple]

### Phase 5: Demo & CLI Implementation (MANDATORY)
- [ ] 7.0 Create exhaustive demo [Medium]
  - [ ] 7.1 Write demo tests first [Simple]
  - [ ] 7.2 Implement comprehensive usage examples [Medium]
  - [ ] 7.3 Cover all protocol implementations [Medium]
  - [ ] 7.4 Include error handling scenarios [Simple]
  - [ ] 7.5 Add performance demonstrations [Simple]
  - [ ] 7.6 Document demo scenarios [Simple]

- [ ] 8.0 Build CLI interface [Medium]
  - [ ] 8.1 Write CLI tests first [Simple]
  - [ ] 8.2 Design short, memorable commands [Simple]
  - [ ] 8.3 Implement core CLI functionality [Medium]
  - [ ] 8.4 Add help and documentation [Simple]
  - [ ] 8.5 Include command examples [Simple]
  - [ ] 8.6 Test CLI integration with plugins [Simple]

## Task Summary with Time Estimates

| Task ID | Task Description | Complexity | Solo Time | Claude Time | Notes |
|---------|------------------|------------|-----------|-------------|-------|
| 1.0 | Design StorageProtocol | Complex | 3h | 1.5h | Define contract |
| 1.1 | └─ Define required methods | Simple | 30m | 15m | save, load, delete |
| 1.2 | └─ Define optional methods | Simple | 30m | 15m | bulk operations |
| 1.3 | └─ Write contract tests | Complex | 2h | 45m | All plugins must pass |
| 1.4 | └─ Error handling specs | Medium | 1h | 30m | Error requirements |
| 1.5 | └─ Document protocol | Simple | 30m | 15m | API docs |
| 1.6 | └─ Compliance validator | Medium | 1.5h | 45m | Validation framework |
| **Phase 1** | **Protocol Definition Total** | | **8h** | **3.75h** | |
| | | | | | |
| 2.0 | Build FileStorage plugin | Medium | 4h | 2h | REFERENCE |
| 2.1 | └─ Write tests | Medium | 1h | 30m | Plugin-specific |
| 2.2 | └─ Implement methods | Medium | 1.5h | 45m | Protocol compliance |
| 2.3 | └─ Pass contract tests | Simple | 30m | 15m | Verify compliance |
| 2.4 | └─ Optional methods | Simple | 30m | 15m | Extended features |
| 2.5 | └─ FileStorage features | Simple | 30m | 15m | File-specific |
| 2.6 | └─ Integration tests | Simple | 45m | 20m | End-to-end |
| 2.7 | └─ Documentation | Simple | 30m | 15m | Plugin guide |
| **Phase 2** | **Reference Plugin Total** | | **5.25h** | **2.5h** | |
| | | | | | |
| 3.0 | Build S3Storage plugin | Medium | 3h | 1.5h | PARALLEL |
| 4.0 | Build DBStorage plugin | Complex | 4h | 2h | PARALLEL |
| 5.0 | Build RedisStorage plugin | Medium | 2.5h | 1.25h | PARALLEL |
| **Phase 3** | **Plugins (Sequential)** | | **9.5h** | **4.75h** | If done one by one |
| **Phase 3** | **Plugins (Parallel)** | | **4h** | **2h** | Max time (DBStorage) |
| | | | | | |
| 6.0 | Build plugin management | Medium | 3h | 1.5h | Registry system |
| 6.1 | └─ Write registry tests | Medium | 45m | 20m | Test-first |
| 6.2 | └─ Create PluginRegistry | Medium | 45m | 25m | Core class |
| 6.3 | └─ Plugin discovery | Simple | 30m | 15m | Auto-discovery |
| 6.4 | └─ Plugin switching | Medium | 45m | 20m | Runtime switch |
| 6.5 | └─ Integration tests | Medium | 45m | 20m | End-to-end |
| 6.6 | └─ Performance tests | Simple | 30m | 15m | Benchmarks |
| **Phase 4** | **Registry Total** | | **3.5h** | **1.75h** | |
| | | | | | |
| 7.0 | Create exhaustive demo | Medium | 2.5h | 1.25h | MANDATORY |
| 7.1 | └─ Write demo tests | Simple | 30m | 15m | Test scenarios |
| 7.2 | └─ Usage examples | Medium | 1h | 30m | Comprehensive |
| 7.3 | └─ Cover all protocols | Medium | 45m | 25m | All implementations |
| 7.4 | └─ Error scenarios | Simple | 15m | 10m | Edge cases |
| 7.5 | └─ Performance demos | Simple | 15m | 10m | Benchmarks |
| 7.6 | └─ Document scenarios | Simple | 15m | 10m | Documentation |
| | | | | | |
| 8.0 | Build CLI interface | Medium | 2h | 1h | MANDATORY |
| 8.1 | └─ Write CLI tests | Simple | 30m | 15m | Test commands |
| 8.2 | └─ Design commands | Simple | 15m | 10m | Short & memorable |
| 8.3 | └─ Core functionality | Medium | 45m | 20m | Main CLI logic |
| 8.4 | └─ Help & docs | Simple | 15m | 10m | Usage docs |
| 8.5 | └─ Command examples | Simple | 15m | 10m | Example usage |
| 8.6 | └─ Integration tests | Simple | 20m | 15m | CLI + plugins |
| **Phase 5** | **Demo & CLI Total** | | **4.5h** | **2.25h** | **MANDATORY** |

## Total Time Estimates

| Execution Mode | Solo Time | Claude Time | Time Saved |
|----------------|-----------|-------------|------------|
| Sequential (all tasks one by one) | 30.5h | 15h | 51% reduction |
| With Parallelization (Phase 3) | 25h | 12.25h | 61% reduction |
| **Speed-up Factor** | | **2-2.5x faster** | |

## TDD Cycle for Each Task
1. **RED**: Write failing test first
2. **GREEN**: Write minimal code to pass
3. **REFACTOR**: Clean up, optimize, simplify names

## Protocol/Plugin Development Rules
1. **Protocol First**: Define complete contract before any plugin
2. **Contract Tests**: Define behavior ALL plugins must support
3. **Reference Plugin**: Build simplest implementation completely
4. **Validate Protocol**: Ensure protocol is complete via reference
5. **Parallel Work**: Only after protocol is validated
6. **Consistent API**: All plugins follow exact protocol

## Protocol Compliance Checklist
- [ ] All required methods implemented
- [ ] All contract tests pass
- [ ] Error handling follows protocol spec
- [ ] Optional methods properly marked
- [ ] Plugin-specific features don't break protocol
- [ ] Documentation describes protocol compliance

## Dependencies
- **Critical**: Plugins CANNOT start until protocol is defined
- Reference plugin must validate protocol completeness
- Contract tests must be comprehensive before parallel work
- All plugins must pass ALL contract tests
- Integration tests after all plugins complete

## Test Strategy
- **Factory-boy**: Use for all test data generation
- **Contract tests**: Protocol-level tests ALL plugins must pass
- **Plugin tests**: Implementation-specific tests with factories
- **Integration tests**: Verify plugin switching/registry
- **Demo tests**: Verify exhaustive demo scenarios work
- **CLI tests**: Test all CLI commands and interactions
- **Compliance tests**: Automated protocol compliance validation
- **Coverage target**: 100% for protocol, 90% for plugins
- **Test organization**: All factories in `tests/factories/`

## Code Quality Checklist
- [ ] Protocol is minimal and complete
- [ ] Contract tests are comprehensive
- [ ] Reference plugin reviewed and approved
- [ ] All plugins pass contract tests
- [ ] Names are short and clear
- [ ] Plugin-specific features documented
- [ ] Protocol changes tracked and versioned
- [ ] Exhaustive demo covers all scenarios
- [ ] CLI commands are short and memorable
- [ ] CLI help documentation is clear

## Interactive Decision Points
1. **Protocol Design**: "Does this protocol capture all required behaviors?"
2. **Reference Selection**: "Which plugin should be our reference implementation?"
3. **Protocol Validation**: "Does the reference prove the protocol is complete?"
4. **Before Parallel**: "Protocol validated? Ready to build others in parallel?"
5. **During Parallel**: "Any protocol amendments needed?"
6. **Demo Planning**: "What scenarios should the exhaustive demo cover?"
7. **CLI Design**: "Which commands would be most useful? Keep them short!"
8. **After Completion**: "All plugins compliant? Demo comprehensive? CLI intuitive?"

## Notes
- Protocol defines the contract, plugins implement it
- Follow TDD strictly - no code without tests
- Reference plugin validates protocol completeness
- Keep names concise but clear about protocol vs plugin
- Contract tests are the specification
- All plugins must be substitutable via protocol
- Document protocol requirements clearly
- Version protocols when breaking changes needed
- **Demo must be exhaustive** - cover every feature, edge case, and integration
- **CLI commands must be short** - prioritize usability and memorability
- Demo and CLI are not optional - they're mandatory deliverables
```

Save as `claudify/[module]/tasks-[prd].md`

## Key Principles
- **Protocol defines contract**: Clear separation between interface and implementation
- **Contract tests are law**: All plugins must pass protocol tests
- **Reference validates protocol**: First plugin proves protocol completeness
- **Interactive confirmation**: Always confirm protocol and reference choice
- **Parallel only after validation**: Protocol must be proven before parallel work
- **TDD is mandatory**: Tests always come first
- **Names distinguish role**: Protocol vs Plugin naming is clear
- **RED-GREEN-REFACTOR**: Follow the cycle religiously
- Use deep thinking for complex analysis
- Ask focused questions, not overwhelming lists
- Document protocol specifications thoroughly