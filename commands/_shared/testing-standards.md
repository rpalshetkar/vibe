# Testing Standards & Patterns

## Core Testing Philosophy

### Test-Driven Development (TDD)
1. **RED**: Write failing test first
2. **GREEN**: Write minimal code to pass  
3. **REFACTOR**: Clean up while tests stay green

### Testing Principles
- **Tests first, always**: No code without tests
- **Factory-only data**: Use factory-boy for all test fixtures
- **Mirror structure**: tests/ follows src/ exactly
- **Zero duplication**: Parameterize similar test patterns
- **Marker-based**: Unit/integration via pytest markers

## Test Organization

### Directory Structure
```
tests/
├── conftest.py                    # Global fixtures
├── factories/                     # factory-boy generators
│   ├── __init__.py
│   ├── user_factory.py
│   └── product_factory.py
├── [module1]/                     # Mirror src/module1/
│   ├── unit/
│   │   └── test_service.py       
│   └── integration/
│       └── test_service.py
└── [module2]/                     # Mirror src/module2/
    └── unit/
        └── test_handlers.py
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
pytest -m unit              # Only unit tests (fast, mocked)
pytest -m integration       # Only integration tests (slower, real)
pytest -m "not integration" # All tests except integration
pytest -m performance       # Only performance tests
```

## Factory-boy Test Data

### Factory Definition
```python
# tests/factories/user_factory.py
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
    
    # Relationships
    profile = SubFactory('tests.factories.ProfileFactory')
    
    @factory.post_generation
    def tags(self, create, extracted, **kwargs):
        if extracted:
            for tag in extracted:
                self.tags.add(tag)

# tests/factories/__init__.py
from .user_factory import UserFactory
from .profile_factory import ProfileFactory
```

### Factory Usage Patterns
```python
# Basic usage
user = UserFactory.build()          # Build without saving
user = UserFactory.create()         # Create and save to DB
users = UserFactory.build_batch(5)  # Build multiple

# Custom overrides
admin = UserFactory.build(is_active=True, role='admin')
inactive = UserFactory.build(is_active=False)

# With relationships
user_with_tags = UserFactory.create(tags=['python', 'testing'])
```

## Parameterization Over Duplication

### Group Similar Tests
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

### Complex Parameterization
```python
@pytest.mark.parametrize("user_type,permissions", [
    ("admin", ["read", "write", "delete"]),
    ("editor", ["read", "write"]),
    ("viewer", ["read"]),
])
def test_user_permissions(user_service, user_type, permissions):
    user = UserFactory.build(role=user_type)
    result = user_service.get_permissions(user)
    assert result == permissions
```

## Mock vs Real Object Control

### Smart Fixtures
```python
# conftest.py
@pytest.fixture
def user_repository(request):
    """Auto-switching repository fixture."""
    if request.node.get_closest_marker('unit'):
        return Mock(spec=UserRepository)
    return UserRepository()

@pytest.fixture
def database(request):
    """Auto-switching database fixture."""
    if request.node.get_closest_marker('unit'):
        return Mock()
    # Return real database connection for integration tests
    return create_test_database()
```

### Mock Patterns
```python
def test_user_service_with_mock(mock_user_repository):
    # Setup mock behavior
    mock_user_repository.find_by_id.return_value = UserFactory.build(id=1)
    
    service = UserService(mock_user_repository)
    user = service.get_user(1)
    
    # Verify mock calls
    mock_user_repository.find_by_id.assert_called_once_with(1)
    assert user.id == 1
```

## Test Configuration

### conftest.py Template
```python
import pytest
import factory
from unittest.mock import Mock
from tests.factories import *

@pytest.fixture(autouse=True)
def reset_factory_sequence():
    """Reset factory sequences for each test."""
    factory.fuzzy.reseed_random(42)

@pytest.fixture
def mock_database():
    return Mock()

@pytest.fixture  
def real_database():
    # Setup real test database
    pass

@pytest.fixture
def database(request):
    """Smart database fixture."""
    if request.node.get_closest_marker('unit'):
        return Mock()
    return real_database()
```

### pytest Configuration
```ini
# pytest.ini or pyproject.toml
[tool:pytest]
markers =
    unit: Unit tests with mocked dependencies
    integration: Integration tests with real objects  
    performance: Performance and benchmark tests
    slow: Tests that take longer to run

testpaths = ["tests"]
addopts = "--cov --cov-report=term-missing --strict-markers"
```

## Test Naming & Organization

### Test Function Names
```python
# ✅ Good - Clear and specific
def test_create_user_with_valid_data():
def test_create_user_with_invalid_email():
def test_delete_user_not_found():

# ❌ Bad - Too verbose or vague
def test_should_create_user_when_valid_data_provided():
def test_user_stuff():
```

### Test Class Organization
```python
class TestUserService:
    """Group related user service tests."""
    
    def test_create_user(self):
        pass
        
    def test_update_user(self):
        pass
        
    def test_delete_user(self):
        pass

class TestUserValidation:
    """Group validation-specific tests."""
    
    @pytest.mark.parametrize("email", ["invalid", "", None])
    def test_invalid_email_formats(self, email):
        pass
```

## Coverage Standards

### Targets
- **Line coverage**: 90%+
- **Branch coverage**: 80%+  
- **Critical paths**: 100%

### Coverage Commands
```bash
# Run with coverage
pytest --cov --cov-report=term-missing

# Generate HTML report
pytest --cov --cov-report=html

# Fail if below threshold
pytest --cov --cov-fail-under=90
```

## Anti-Patterns to Avoid

### ❌ Don't Do This
```python
# Hardcoded test data
def test_user_creation():
    user_data = {"username": "testuser", "email": "test@example.com"}
    
# Duplicate test logic
def test_create_admin_user():
    # Same logic as regular user test
    pass
    
def test_create_editor_user():
    # Same logic as regular user test  
    pass

# Inline type ignores for imports
import some_library  # type: ignore
```

### ✅ Do This Instead
```python
# Factory-based test data
def test_user_creation():
    user_data = UserFactory.build()
    
# Parameterized tests
@pytest.mark.parametrize("role", ["admin", "editor", "viewer"])
def test_create_user_with_role(role):
    user_data = UserFactory.build(role=role)
    
# mypy.ini configuration
[mypy-some_library.*]
ignore_missing_imports = true
```

## Python Standards Reference
See `_shared/python-standards.md` for Python version, tools, and configuration standards.