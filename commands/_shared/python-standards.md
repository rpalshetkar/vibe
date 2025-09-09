# Python Development Standards

## Core Requirements

### Python Version & Tools
- **Python**: 3.12+ only
- **Package Manager**: `uv` only (no pip/poetry/pipenv)
- **Formatter**: `ruff` 
- **Type Checker**: `mypy --strict`
- **Testing**: `pytest` with coverage
- **Test Data**: `factory-boy` for fixture generation

### Project Structure
```
project/
├── [module1]/         # Direct module structure (no src/)
├── [module2]/         
├── tests/             # Mirrors module structure
│   ├── conftest.py
│   ├── factories/     # factory-boy test data
│   └── [module1]/
├── pyproject.toml     # uv configuration
├── .ruff.toml        # Formatter config
├── .mypy.ini         # Type checker
└── README.md
```

## Configuration Templates

### pyproject.toml
```toml
[project]
name = "[project]"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = []

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "pytest-cov>=4.0",
    "mypy>=1.0",
    "ruff>=0.1.0",
    "factory-boy>=3.3",
    "faker>=20.0"
]

[tool.ruff]
line-length = 88
target-version = "py312"

[tool.mypy]
strict = true
python_version = "3.12"

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "--cov --cov-report=term-missing"
```

### .ruff.toml
```toml
line-length = 88
target-version = "py312"

[lint]
select = ["E", "W", "F", "I", "N", "UP", "ANN", "S", "B"]
ignore = ["ANN101", "ANN102"]  # Skip self/cls annotations

[format]
quote-style = "double"
indent-style = "space"
```

### mypy.ini
```ini
[mypy]
strict = true
python_version = 3.12
warn_return_any = true
warn_unused_configs = true

# Third-party library ignores (add as needed)
[mypy-requests.*]
ignore_missing_imports = true
```

## Environment Setup Commands

### Project Initialization
```bash
# Initialize with uv
uv init
uv add --dev pytest pytest-cov mypy ruff factory-boy faker

# Setup pre-commit (optional)
uv add --dev pre-commit
pre-commit install

# Run initial checks
uv run ruff check
uv run mypy --strict .
uv run pytest
```

### Quality Checks Sequence
```bash
# Apply all auto-fixes
uv run ruff check --fix .
uv run ruff check --fix --unsafe-fixes .
uv run ruff format .

# Type checking
uv run mypy --strict .

# Test with coverage
uv run pytest --cov --cov-report=term-missing

# Verify fixes didn't break anything
uv run python -m py_compile **/*.py
```

## Key Principles

- **No src/ folder**: Direct module structure
- **Strict typing**: mypy --strict with no compromises
- **Factory-only test data**: No hardcoded test fixtures
- **uv only**: Never use pip/poetry/pipenv
- **Tests mirror structure**: tests/ follows module/ exactly
- **Coverage targets**: 90%+ line coverage, 80%+ branch coverage
- **Third-party types**: Handle via mypy.ini, never inline ignores

## Type Annotation Standards

```python
# Function signatures
def process_data(data: Dict[str, Any]) -> Optional[List[str]]:
    """Process data and return results."""
    return data.get("items", [])

# Class definitions  
class UserService:
    def __init__(self, repository: UserRepository) -> None:
        self._repository = repository
    
    def create_user(self, data: UserData) -> User:
        return self._repository.save(data)

# Generic types
T = TypeVar('T')

def safe_get(items: List[T], index: int) -> Optional[T]:
    return items[index] if 0 <= index < len(items) else None
```

## Testing Standards Reference
See `_shared/testing-standards.md` for comprehensive testing patterns.

## File Formats Reference  
See `_shared/file-formats.md` for common output templates.