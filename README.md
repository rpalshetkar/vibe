# VIBE - AI-Assisted Development Workflow System

## Overview

VIBE (Versatile Intelligence-Based Engineering) is a structured development workflow system that leverages AI to streamline software development through systematic requirements documentation, feature extraction, task generation, and implementation.

## Quick Start

```bash
# Clone the repository
git clone <repository-url> ~/.claude

# Start a new project
cd your-project
/xprd       # Create Product Requirements Document
/xspec      # Extract features from PRD
/xtasks     # Generate tasks from features
/xgo        # Implement tasks systematically
```

## Core Commands

| Command | Purpose | Description |
|---------|---------|-------------|
| `/xprd` | Requirements | Create a Product Requirements Document with AI guidance |
| `/xspec` | Features | Extract and organize features from existing PRD |
| `/xtasks` | Planning | Generate detailed task list from PRD and features |
| `/xgo` | Implementation | Process and implement tasks one by one |
| `/xpyinit` | Setup | Initialize Python project with best practices |
| `/xpyfix` | Maintenance | Fix Python code issues and apply best practices |
| `/xthink` | Analysis | Extended thinking for complex problems |

## Directory Structure

```
your-project/
├── VIBE/                  # VIBE workflow artifacts
│   ├── PRD.md            # Product Requirements Document
│   ├── FEATURES.md       # Extracted features list
│   └── TASKS/            # Task implementation files
│       ├── task-001.md
│       ├── task-002.md
│       └── ...
└── CLAUDE.md             # Project-specific AI instructions
```

## Workflow Process

### 1. Requirements Definition (`/xprd`)
Start by creating a comprehensive Product Requirements Document that captures:
- Business objectives
- User stories
- Technical requirements
- Success criteria

### 2. Feature Extraction (`/xspec`)
Automatically extract and organize features from your PRD:
- Groups related requirements
- Creates feature identifiers (e.g., AU-LOGIN, DM-EXPORT)
- Maps features to user stories

### 3. Task Generation (`/xtasks`)
Generate actionable development tasks:
- Breaks features into implementable units
- Creates dependency chains
- Estimates complexity and effort

### 4. Implementation (`/xgo`)
Systematically implement tasks with AI assistance:
- Works through tasks one at a time
- Maintains context across implementation
- Ensures test coverage and code quality

## Python Development Standards

### Core Requirements
- **Python Version**: 3.12+ only
- **Package Manager**: `uv` (no pip/poetry/pipenv)
- **Type Checking**: `mypy --strict`
- **Formatting**: `ruff`
- **Testing**: `pytest` with 100% coverage for public APIs

### Project Structure
```
project/
├── src/
│   └── project_name/
│       ├── __init__.py
│       ├── core/
│       ├── api/
│       └── utils/
├── tests/
├── pyproject.toml
├── ruff.toml
└── mypy.ini
```

## Configuration Files

### Python Templates
- `configs/python/pyproject.toml.template` - Modern Python packaging
- `configs/python/ruff.toml.template` - Code formatting and linting
- `configs/python/mypy.ini.template` - Type checking configuration

### Editor Configuration
- `configs/vscode/settings.json` - VSCode workspace settings
- `configs/vscode/extensions.json.template` - Recommended extensions

## Best Practices

### Collaboration Guidelines
- **Challenge assumptions** - Question unclear or suboptimal requests
- **Think critically** - Consider edge cases and performance implications
- **Seek clarification** - Ask for details when requirements are ambiguous
- **Propose improvements** - Suggest better patterns and implementations

### Naming Conventions
- No numerical prefixes/suffixes for files
- Use meaningful acronyms for features
- Consistent snake_case for Python
- Clear, descriptive variable names

### Implementation Process
1. Use TodoWrite tool for task planning
2. Work on one sub-task at a time
3. Run tests before marking complete
4. Commit after completing parent tasks
5. Follow conventional commit format

## Installation

### System Requirements
- Git
- Python 3.12+
- `uv` package manager
- Claude Code CLI

### Setup
```bash
# Install uv if not present
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone VIBE system
git clone <repository-url> ~/.claude

# Verify installation
ls ~/.claude/commands/
```

## Command Reference

All commands are markdown files in the `commands/` directory that provide structured instructions to Claude Code for specific workflows.

### Available Commands
- `xprd.md` - PRD creation workflow
- `xspec.md` - Feature extraction logic
- `xtasks.md` - Task generation system
- `xgo.md` - Implementation processor
- `xpyinit.md` - Python project initializer
- `xpyfix.md` - Python code fixer
- `xthink.md` - Extended analysis mode

## Contributing

1. Follow the Python development standards
2. Ensure all Python code passes `mypy --strict`
3. Maintain 100% test coverage for public APIs
4. Use conventional commit messages
5. Update documentation for new features

## License

See LICENSE file for details.

## Support

For issues or questions:
- Review CLAUDE.md for AI collaboration guidelines
- Check command documentation in `commands/` directory
- Consult development rules in `devrules/` directory