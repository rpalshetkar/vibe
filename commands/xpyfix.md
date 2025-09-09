# xpyfix - Python Code Quality Fixer

## Purpose
Automatically fix Python code quality issues with best practices and standards.

## Process

### 1. Analysis Phase
Run all quality checks to identify issues:
```bash
# Apply ALL auto-fixes (imports are handled via ruff.toml config)
uv run ruff check --fix .

# Apply unsafe fixes with caution (review changes)
uv run ruff check --fix --unsafe-fixes .

# Format code
uv run ruff format .

# Type checking
uv run mypy --strict .

# Test coverage
uv run pytest --cov --cov-report=term-missing

# Security scan (if bandit installed)
uv run bandit -r . 2>/dev/null || true
```

### 2. Auto-Fix Categories

**Code Formatting**
- Apply ruff formatting
- Fix import sorting
- Remove unused imports
- Fix line length issues

**Type Annotations**
- Add missing return types
- Fix incompatible types
- Add generic type parameters
- Convert Any to specific types

**Third-Party Library Handling**
- Detect libraries without type stubs
- Add library sections to mypy.ini
- Never add inline `# type: ignore` for imports
- Keep source files clean

**Test Coverage**
- Identify uncovered lines
- Generate test stubs for missing tests using factory-boy
- Fix broken test assertions
- Update test fixtures to use factories
- Migrate hardcoded test data to factory-boy patterns

**Common Issues**
- Fix mutable default arguments
- Remove dead code
- Fix circular imports
- Resolve naming conflicts

### 3. Interactive Fixes
For issues that can't be auto-fixed:

**Type Errors**
- "Function needs return type. Suggested: -> Dict[str, Any]"
- "Parameter needs type hint. Add: param: str"

**Third-Party Libraries**
- "Library 'requests' has no type stubs. Adding to mypy.ini..."
- "Multiple untyped imports from 'boto3'. Configuring mypy.ini..."

**Test Gaps**
- "Function 'process_data' lacks tests. Create test?"
- "Branch coverage missing for if/else. Add test case?"

**Code Smells**
- "Function too complex (cyclomatic: 15). Split?"
- "Duplicate code detected. Extract to function?"

### 4. Fix Priority Order
1. **Critical**: Syntax errors, import failures
2. **High**: Type errors, failing tests
3. **Medium**: Missing types, low coverage
4. **Low**: Style issues, conventions

### 5. Complete Auto-Fix Command Sequence
Run these commands in order for maximum auto-fixing:
```bash
# Step 1: Apply all safe fixes (imports handled by ruff.toml)
uv run ruff check --fix .

# Step 2: Apply unsafe fixes (review changes carefully)
uv run ruff check --fix --unsafe-fixes .

# Step 3: Format everything
uv run ruff format .

# Step 4: Verify fixes didn't break anything
uv run python -m py_compile **/*.py

# Step 5: Check what's left
uv run ruff check .
uv run mypy --strict .
```

### 6. Validation Steps
After each fix round:
```bash
# Ensure nothing broke
uv run python -m py_compile **/*.py

# Re-run checks
uv run mypy --strict .
uv run ruff check .
uv run pytest

# Show remaining issues
echo "Remaining issues:"
uv run mypy . 2>&1 | grep error: | wc -l
```

## Fix Strategies

### Type Annotation Fixes
```python
# Before
def process(data):
    return data.get("value")

# After  
def process(data: Dict[str, Any]) -> Optional[Any]:
    return data.get("value")
```

### Third-Party Library Type Fixes
```ini
# When mypy reports: Cannot find implementation or library stub for module named "some_library"
# Add to mypy.ini (NOT inline comments):

[mypy-some_library.*]
ignore_missing_imports = true

# For multiple related packages:
[mypy-boto3.*]
ignore_missing_imports = true

[mypy-botocore.*]
ignore_missing_imports = true
```

**Detection Process:**
1. Parse mypy output for "Cannot find implementation" errors
2. Extract library names from error messages
3. Check if library is third-party (not in project)
4. Add appropriate section to mypy.ini
5. Re-run mypy to verify fix

### Test Coverage Fixes with factory-boy
```python
# tests/factories/data_factory.py
import factory
from factory import Faker, SubFactory

class DataFactory(factory.Factory):
    class Meta:
        model = dict
    
    value = Faker('random_int', min=1, max=100)
    name = Faker('word')
    metadata = factory.Dict({
        'created': Faker('date_time'),
        'updated': Faker('date_time')
    })

# Generated test stub using factories
from tests.factories import DataFactory

def test_process_with_empty_dict():
    """Test process with empty input."""
    result = process({})
    assert result is None

def test_process_with_factory_data():
    """Test process with factory-generated data."""
    test_data = DataFactory.build()
    result = process(test_data)
    assert result == test_data['value']

def test_process_with_custom_value():
    """Test process with custom value override."""
    test_data = DataFactory.build(value=42)
    result = process(test_data)
    assert result == 42
```

## Configuration
Read from `.ruff.toml` and `pyproject.toml`:
- Line length settings
- Ignored error codes
- Coverage thresholds
- Type checking strictness

## Output Summary
```
Fixed Issues:
✓ 12 formatting issues
✓ 8 import sorts
✓ 5 type annotations added
✓ 3 tests generated

Remaining Issues:
⚠ 2 complex type errors (manual fix needed)
⚠ 1 circular import (refactor needed)

Coverage: 87% → 94%
Type Coverage: 78% → 91%
```

## Key Principles
- Fix automatically when safe
- Never break working code
- Maintain test coverage
- Follow Python standards strictly (see `_shared/python-standards.md`)
- Use mypy.ini for third-party library issues
- Never pollute source with `# type: ignore` for imports

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`