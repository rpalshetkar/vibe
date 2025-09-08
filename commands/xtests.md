
# xtests - Comprehensive Test Infrastructure Generator

## Purpose
Generate comprehensive test infrastructure with smart mock/real object switching, following factory-boy patterns and pytest best practices.

## Features
- **Context-aware test generation**: Analyze source code structure and generate appropriate tests
- **Mock vs Real switching**: Use pytest markers for unit (mocked) vs integration (real) tests
- **Factory-based test data**: Generate factory-boy classes for realistic test data
- **Test infrastructure**: Create fixtures, conftest.py, and test utilities
- **Multiple test types**: Unit, integration, performance, error handling tests
- Never pollute the code base with yamls and config. Try to keep these files totally separate and possibly use factory-boy and fixtures so that these could be reused across tests
- If test patterns are similar run the tests in the loop than adding slight variations here and there
- STRICTLY No backward compatibility is expected

## Usage

### Basic Test Generation
```bash
/xtests [file_or_module]        # Analyze and generate comprehensive tests
/xtests --unit [file]           # Generate unit tests with mocks
/xtests --integration [module]  # Generate integration tests with real objects
/xtests --factories [model]     # Generate factory-boy test data factories
```

### Advanced Options
```bash
/xtests --analyze               # Deep analysis of existing test patterns
/xtests --fixtures [module]     # Generate conftest.py with fixtures
/xtests --performance [class]   # Generate performance benchmarks
```

## Test Strategy

### 1. Mock vs Real Object Control
Uses pytest markers to control test execution:

```python
@pytest.mark.unit
def test_user_service_unit(mock_user_repository):
    """Unit test with mocked dependencies."""
    pass

@pytest.mark.integration  
def test_user_service_integration(real_user_repository):
    """Integration test with real database."""
    pass
```

Run with:
```bash
pytest -m unit              # Only unit tests (fast, mocked)
pytest -m integration       # Only integration tests (slower, real)
pytest -m "not integration" # All tests except integration
```

### 2. Factory-Boy Test Data Generation
Generates factory classes following pyrules.md standards:

```python
# Generated in tests/factories/user_factory.py
import factory
from factory import Faker, SubFactory
from models.user import User

class UserFactory(factory.Factory):
    class Meta:
        model = User
    
    username = Faker('user_name')
    email = Faker('email')
    age = Faker('random_int', min=18, max=100)
    is_active = True
```

### 3. Smart Fixture Generation
Creates configurable fixtures in conftest.py:

```python
@pytest.fixture
def user_repository(request):
    """Return mock or real repository based on test marker."""
    if hasattr(request.node, 'get_closest_marker') and request.node.get_closest_marker('unit'):
        return MockUserRepository()
    return RealUserRepository()
```

## Test Types Generated

### Unit Tests
- Mock all external dependencies
- Test business logic in isolation
- Fast execution, no I/O operations
- Use factory-boy for test data

### Integration Tests  
- Real database/API connections
- Test component interactions
- Slower execution, full stack testing
- Test error conditions and timeouts

### Performance Tests
- Benchmark critical operations
- Memory usage profiling
- Concurrent operation testing
- Load testing scenarios

### Error Handling Tests
- Exception scenarios
- Invalid input validation
- Resource cleanup verification
- Edge case handling

## Generated File Structure

```
tests/
├── conftest.py              # Central fixtures and configuration
├── factories/               # Factory-boy test data generators
│   ├── __init__.py
│   ├── user_factory.py
│   └── product_factory.py
├── unit/                    # Unit tests with mocks
│   ├── test_user_service.py
│   └── test_product_service.py
├── integration/             # Integration tests with real objects
│   ├── test_user_workflow.py
│   └── test_database_operations.py
├── performance/             # Performance and benchmark tests
│   └── test_benchmarks.py
└── utils/                   # Test utilities and helpers
    └── assertions.py
```

## Implementation Process

### 1. Code Analysis Phase
- Scan source file/module for classes, functions, dependencies
- Identify external dependencies that need mocking
- Detect async operations requiring special handling
- Find existing test patterns in codebase

### 2. Test Generation Phase
- Generate factory classes for data models
- Create unit tests with appropriate mocks
- Generate integration tests with real dependencies
- Add performance benchmarks for critical paths

### 3. Infrastructure Phase
- Update/create conftest.py with smart fixtures
- Add pytest.ini configuration for markers
- Generate test utilities and custom assertions
- Set up proper test data cleanup

### 4. Validation Phase
- Ensure 100% test coverage for public APIs
- Validate all tests pass independently
- Check mock vs real switching works correctly
- Verify factory-boy data generation

## Configuration

### pytest.ini Integration
Automatically adds test markers:
```ini
[tool:pytest]
markers =
    unit: Unit tests with mocked dependencies
    integration: Integration tests with real objects
    performance: Performance and benchmark tests
    slow: Tests that take longer to run
```

### Coverage Requirements
- 100% coverage for public APIs
- Branch coverage for error conditions
- Integration test coverage for critical workflows

## Key Principles

1. **No Hardcoded Test Data**: All test data via factory-boy
2. **Clear Separation**: Unit vs integration via pytest markers
3. **Realistic Data**: Use Faker for believable test data
4. **Fast Unit Tests**: Mocked dependencies, no I/O
5. **Comprehensive Coverage**: Happy path, errors, edge cases
6. **Clean Architecture**: Proper test organization and utilities

## Error Handling

- Validates source code structure before generation
- Checks for existing test conflicts
- Ensures factory dependencies are available
- Warns about missing pytest configuration

## Integration with VIBE Workflow

- Follows pyrules.md standards strictly
- Uses existing project patterns and conventions
- Integrates with factory-boy and pytest ecosystem
- Maintains clean separation of concerns
