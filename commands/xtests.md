# xtests - Comprehensive Test Infrastructure Generator

## Purpose
Generate comprehensive test infrastructure mirroring codebase structure with smart mock/real switching, parameterization, and zero duplication.

## Process

### 1. Duplication Check Phase
Before generating any tests:
- **Scan existing tests** for similar patterns and functions
- **Identify reusable fixtures** and factories already available
- **Check for parameterization opportunities** in existing code
- **Analyze test coverage gaps** only where tests are missing
- **Map existing test structure** to avoid conflicts

### 2. Structure Analysis Phase  
- **Map source code structure** to determine test directory layout
- **Identify dependencies** requiring mocking vs real objects
- **Detect async patterns** and database interactions
- **Find model classes** needing factory generation
- **Determine test markers** needed (unit/integration/performance)

### 3. Smart Generation Phase
Generate only what's missing:
- **Create factories** for new models only (reuse existing)
- **Build parameterized tests** grouping similar scenarios  
- **Mirror directory structure** following codebase exactly
- **Add pytest markers** for unit/integration switching
- **Integrate with existing conftest.py** patterns

### 4. Integration Phase
- **Update conftest.py** with new fixtures (avoid duplication)
- **Configure pytest markers** if missing from configuration
- **Validate zero duplication** with existing tests
- **Run test suite** to ensure no conflicts or naming issues

## Test Organization Strategy

### Mirror Structure Approach
```
tests/
├── conftest.py                    # Global fixtures
├── factories/                     # factory-boy generators
│   ├── __init__.py
│   ├── user_factory.py
│   └── product_factory.py
├── [module1]/                     # Mirror src/module1/
│   └── test_service.py            # All tests in module folder
├── [module2]/                     # Mirror src/module2/
│   └── test_handlers.py           # All tests in module folder
└── integration/                   # Integration tests only
    ├── test_full_workflow.py      # End-to-end integration tests
    └── test_api_integration.py
```

### Test Types & Markers
```python
@pytest.mark.unit
def test_user_service_unit(mock_user_repository):
    """Unit test with mocked dependencies."""
    pass

@pytest.mark.integration
def test_user_service_integration(real_user_repository):
    """Integration test with real database."""
    pass

@pytest.mark.performance
def test_user_service_performance():
    """Performance benchmark test."""
    pass
```

**Run commands:**
```bash
pytest -m unit                    # Only unit tests (fast, mocked)
pytest -m integration             # Only integration tests (slower, real)
pytest -m "not integration"       # All tests except integration
pytest tests/integration/         # Run only integration test folder
pytest tests/module1/             # Run tests for specific module
```

## Smart Mock/Real Object Control

### Auto-Switching Fixtures
```python
@pytest.fixture
def user_repository(request):
    """Auto-switching repository fixture based on test marker."""
    if request.node.get_closest_marker('unit'):
        return Mock(spec=UserRepository)
    return UserRepository()
```

### Parameterization Over Duplication
```python
@pytest.mark.parametrize("input_data,expected", [
    (UserFactory.build(), {"status": "created"}),
    (UserFactory.build(email="invalid"), {"error": "invalid_email"}),
    (UserFactory.build(age=17), {"error": "underage"}),
])
def test_user_validation(user_service, input_data, expected):
    result = user_service.validate(input_data)
    assert result == expected
```

## Command Usage

### Basic Test Generation
```bash
/xtests [file_or_module]        # Analyze and generate comprehensive tests
/xtests --unit [file]           # Generate unit tests with mocks in module folder
/xtests --integration [module]  # Generate integration tests in tests/integration/
/xtests --factories [model]     # Generate factory-boy test data factories
```

### Advanced Options
```bash
/xtests --analyze               # Deep analysis of existing test patterns
/xtests --fixtures [module]     # Generate conftest.py with fixtures
/xtests --performance [class]   # Generate performance benchmarks
```

## Anti-Duplication Strategy

### Pre-Generation Validation
```bash
# Check for existing similar tests before generation
grep -r "def test.*user.*create" tests/
grep -r "UserFactory" tests/factories/
grep -r "@pytest.mark.parametrize.*user" tests/
```

### Similarity Detection Process
1. Parse existing test files using AST analysis
2. Identify function signatures and test patterns
3. Check factory definitions for reusable components
4. Validate parameterization opportunities
5. Only generate truly missing test coverage

## Key Rules
- **Mirror Structure**: tests/[module]/ follows src/[module]/ exactly (no unit/integration subfolders)
- **Zero Hardcoding**: Factory-boy for all test data (see `_shared/testing-standards.md`)
- **Parameterize Similar**: Group test variations, don't duplicate
- **Check First**: Never duplicate existing tests
- **Marker-Based**: Unit/integration via pytest markers (not folder structure)
- **Integration Separation**: End-to-end integration tests go in tests/integration/ folder
- **Coverage Focused**: Generate only missing test coverage

## Test Structure Guidelines

### Module Tests (tests/[module]/)
- **All module-specific tests** go directly in tests/[module]/ folder
- **No unit/integration subfolders** - use pytest markers instead
- **Mix unit and integration tests** in same file when logical
- **File naming**: test_[source_file_name].py

### Integration Tests (tests/integration/)
- **End-to-end workflows** that span multiple modules
- **External service integrations** (databases, APIs, file systems)
- **Full system tests** that require complete setup
- **Cross-module interaction tests**

### Example Structure
```
src/user/service.py         → tests/user/test_service.py
src/user/repository.py      → tests/user/test_repository.py
src/auth/handlers.py        → tests/auth/test_handlers.py
End-to-end workflows        → tests/integration/test_user_workflow.py
```

## Coverage Standards
- **Line coverage**: 90%+
- **Branch coverage**: 80%+
- **Critical paths**: 100%
- Generate tests only for uncovered code paths

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`