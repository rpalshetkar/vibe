# Python Development Standards

## Core Requirements
- Python 3.12+ only
- Package manager: `uv` only (no pip/poetry/pipenv)
- Type checking: `mypy --strict`
- Formatting: `ruff`
- Testing: `pytest` with 100% coverage for public APIs
- Test Data: `factory-boy` for fixture generation

## Technology Stack
- **Web/CLI**: FastAPI (REST), Typer (CLI), Rich (terminal - no print())
- **Data/Validation**: Pydantic 2.10+, DynaConf (config)
- **Async**: asyncpg/motor (DB drivers), httpx (HTTP client)
- **Development**: pytest, loguru (logging), icecream (debug - auto-removed in prod)

## Mandatory Code Standards

### ✅ ALWAYS
- Write Ruff compliant code always so that ruff fix is not required later
- `from __future__ import annotations` first line after docstring
- Return types on ALL functions: `-> ReturnType`
- Use `str | None` not `Optional[str]`, `list[str]` not `List[str]`
- Double quotes for strings
- Keyword-only args after `*,`
- Chain exceptions: `except E as e: raise NewE(msg) from e`
- Assign error messages to variables before raising
- For debugging purpose use icecreams than prints

### ❌ NEVER
- `print()` - use `console.print()`
- Mix data and code. Refactor configs/data out
- Missing return types
- `raise` without `from e`
- Functions > 50 lines
- Direct stdout/stderr writes
- Plaintext passwords/secrets

## File Structure
1. Module docstring (one line)
2. `from __future__ import annotations`
3. Standard library imports
4. Third-party imports
5. Local imports
6. Type definitions
7. Constants

## Architecture Patterns
- Abstract base classes with runtime enforcement
- `__init__` checks for direct instantiation
- Minimal required abstract methods
- Sensible defaults for optional methods
- Domain-specific exception hierarchy with error details
- All models inherit from XObjPrototype
- Pydantic for all validation
- Flat metadata dictionaries
- Namespace-aware design

## Security Requirements
- Validate ALL inputs via Pydantic
- Prevent SQL injection
- Path traversal protection
- HTML escaping by default
- DynaConf for secrets management
- Never log sensitive data
- Redact sensitive fields in repr
- Environment-based configuration

## Performance Standards
- Connection pooling for all resources
- Async operations throughout
- Lazy loading where applicable
- Bulk operations for efficiency
- Cache at appropriate levels with clear invalidation
- TTL-based expiration
- Monitor cache hit rates

## Testing Requirements
- 100% coverage for public APIs
- Test all error conditions
- Integration tests required
- Performance benchmarks
- Arrange-Act-Assert pattern
- Factory-boy for all test data generation
- Test factories in `tests/factories/` directory
- No hardcoded test data in test files
- Reusable fixtures via factories

## Development Workflow
- Conventional commits format
- Clear, concise messages
- Reference issue numbers
- Sign commits
- Type hints complete
- Google-style docstrings with examples
- Tests pass with coverage
- No security vulnerabilities
- Performance acceptable
- Error handling complete

## Quality Gates
- `ruff check --fix` - no warnings
- `mypy --strict` - no errors
- `pytest --cov --cov-report=term-missing` - 100% coverage
- Security scanning - no vulnerabilities
- Performance profiling

## Documentation
- Google-style docstrings (Args, Returns, Raises sections)
- Usage examples required
- API documentation generated
- Architecture decisions recorded

## Naming Conventions
- Classes: PascalCase
- Functions: snake_case
- Constants: UPPER_SNAKE_CASE
- Private: _single_underscore
- Very short and crisp function names and test names but intuitive

## Test Data Organization with factory-boy
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

# tests/test_user.py
from tests.factories import UserFactory

def test_user_creation():
    # Clean test with no data duplication
    user = UserFactory.build()
    assert user.username
    assert '@' in user.email

def test_multiple_users():
    # Generate unique test data batch
    users = UserFactory.build_batch(5)
    assert len(users) == 5
    assert len(set(u.email for u in users)) == 5  # All unique

def test_custom_user():
    # Override specific attributes
    inactive_user = UserFactory.build(is_active=False, age=25)
    assert not inactive_user.is_active
    assert inactive_user.age == 25
```

## Factory-boy Best Practices
- One factory per model/class
- Use `Faker` for realistic test data
- `build()` for unsaved instances, `create()` for saved
- `SubFactory` for related objects
- Traits for common variations
- Sequences for unique values
- Keep factories close to models they test

## Enforcement
Non-compliant code will be rejected in review.
