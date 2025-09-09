# xpyinit - Python Project Initializer

## Purpose
Initialize new Python projects with best practices and standards using the setuppy.sh script.

## Process

### 1. Script Execution
Use the setup script at `configs/setuppy.sh`:
```bash
bash $HOME/.claude/configs/setuppy.sh <project_name> [project_description] [package_dirs]
```

### 2. What the Script Does
- Creates project structure with package directories
- Copies and customizes all configuration templates
- Sets up VS Code configuration
- Initializes git repository with initial commit
- Runs `uv sync --dev` to install dependencies
- Creates basic CLI entry point and test files

### 3. Project Generation
```
project/
├── .github/           # If CI selected
│   └── workflows/
├── [module1]/         # Direct module structure
│   ├── __init__.py
│   ├── core.py
│   └── utils.py
├── [module2]/         # Another module
│   ├── __init__.py
│   └── handlers.py
├── tests/             # Mirrors module structure
│   ├── conftest.py
│   ├── factories/     # factory-boy test data
│   │   ├── __init__.py
│   │   └── base.py
│   ├── [module1]/
│   │   ├── test_core.py
│   │   └── test_utils.py
│   └── [module2]/
│       └── test_handlers.py
├── configs/           # From configs folder
│   └── settings.yaml
├── pyproject.toml     # uv configuration
├── .ruff.toml        # Formatter config
├── .mypy.ini         # Type checker
├── .pre-commit.yaml  # If selected
├── Dockerfile        # If selected
└── README.md
```

### 4. Environment Setup
```bash
# Initialize with uv
uv init
uv add --dev pytest pytest-cov mypy ruff factory-boy faker

# Setup pre-commit if selected
uv add --dev pre-commit
pre-commit install

# Run initial checks
uv run ruff check
uv run mypy --strict .
uv run pytest
```

**Initial Factory Setup**:
```python
# tests/factories/base.py
import factory
from factory import Faker

class BaseFactory(factory.Factory):
    """Base factory for common patterns."""
    created_at = Faker('date_time')
    updated_at = Faker('date_time')

# tests/conftest.py
import pytest
from tests.factories import *  # Import all factories

@pytest.fixture
def factory_session():
    """Reset factory sequences for each test."""
    factory.reseed_random(42)  # Reproducible tests
```

### 5. Configuration Files

**pyproject.toml** (from template):
```toml
[project]
name = "[project]"
version = "0.1.0"
requires-python = ">=3.12"

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

## Key Standards
See `_shared/python-standards.md` for complete requirements:
- **Python**: 3.12+ only
- **Package Manager**: uv only
- **Testing**: pytest with coverage + factory-boy
- **Structure**: Direct modules, no src folder

## Confirmation Points
1. After each configuration choice
2. Before creating file structure
3. After environment setup
4. Before running initial tests

## Output
- Complete Python project structure
- All tools configured and verified
- Tests passing and type checking clean
- README with setup instructions
- Optional: GitHub repository created

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`

## GitHub Integration (Optional)

### 6. Repository Creation
After local verification, ask user:
"Would you like to create a new private GitHub repository for this project? (y/n)"

If yes, proceed with:

**Interactive Setup**:
```bash
# Check GitHub auth status
gh auth status || gh auth login

# Get GitHub username
username=$(gh api user -q .login)
echo "GitHub user: $username"

# Confirm repository details
echo "Repository name: [project-name]"
echo "Visibility: Private"
echo "Description: [project-description]"
echo "Create repository? (y/n)"
```

**Create and Push**:
```bash
# Create private repository
gh repo create [project-name] --private --description "[description]"

# Add remote origin
git remote add origin https://github.com/$username/[project-name].git

# Push initial commit
git push -u origin main

# Show result
echo "✓ Repository created: https://github.com/$username/[project-name]"
```

### 7. Complete Workflow
1. Initialize local project with Python best practices
2. Run all quality checks locally
3. **Ask**: "Create GitHub repository?" 
4. If yes: Create private repo and push
5. If no: Provide instructions for later
6. Show final project status