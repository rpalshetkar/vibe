# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Overview

VIBE (Versatile Intelligence-Based Engineering) is a structured development workflow system for AI-assisted software development through systematic PRD creation, feature extraction, task generation, and implementation.

**Important**: All VIBE documentation and progress files are stored in `{PROJECT_ROOT}/claudify/{module}/` folders to keep code directories clean.

## Quick Commands

```bash
/xprd       # Create a new Product Requirements Document
/xspec      # Extract features from an existing PRD
/xtasks     # Generate task list from a PRD
/xgo        # Implement tasks one by one
/xpyinit    # Initialize new Python project with best practices
/xpyfix     # Fix Python code issues and apply best practices
/xthink     # Extended thinking for complex problems
/xdoc       # Generate/update comprehensive documentation
```

## Key Paths

- **Base**: `$HOME/.claude` or `$HOME/dev/vibe`
  - `commands/` - workflow commands (xprd, xspec, xtasks, xgo, xpyinit, xpyfix, xthink, xdoc)
  - `devrules/` - development standards (pyrules.md)
  - `configs/` - configuration templates
    - `python/` - Python project templates (mypy.ini, pyproject.toml, ruff.toml)
    - `vscode/` - VSCode settings and extensions
    - `git/` - Git configuration
- **Project**: `{PROJECT_ROOT}/claudify/`
  - `claudify/{module}/` - Module-specific PRDs, features, tasks, and progress files
  - All VIBE documentation stays in claudify to avoid polluting code folders

## Core Guidelines

- **Think critically** before implementing
- **Ask for clarification** when requirements are ambiguous
- **Use TodoWrite tool** to plan tasks when using /xgo
- **Test before completing** tasks
- **Follow conventions** in existing codebase

## Python Standards

- Python 3.12+, `uv` package manager only
- Type checking: `mypy --strict`
- Formatting: `ruff`
- Testing: `pytest` with coverage

## Testing Guidelines

- **Test names**: Keep test names short and descriptive
- **Avoid**: `test_should_handle_complex_scenario_when_user_provides_invalid_input_and_expects_error_message`
- **Prefer**: `test_invalid_input_error`
- Focus on what's being tested, not implementation details