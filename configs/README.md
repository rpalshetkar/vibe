# XDS Framework Reference Configurations

This directory contains standardized configuration templates for XDS Framework projects, providing consistent development environments and tooling across all projects.

## Structure

```
~/.claude/configs/
├── vscode/                    # VS Code configurations
│   ├── settings.json         # Complete VS Code settings
│   ├── markdown-preview.css  # Custom dark theme CSS for markdown
│   └── extensions.json.template  # Recommended VS Code extensions
├── python/                    # Python project configurations  
│   ├── pyproject.toml.template    # Python project configuration
│   ├── ruff.toml.template         # Ruff linting configuration
│   └── .editorconfig.template     # Editor configuration
├── git/                       # Git configurations
│   └── .gitignore.template    # Python project .gitignore
├── scripts/                   # Setup and utility scripts
│   └── setup-project.sh      # Automated project setup script
└── README.md                 # This file
```

## Quick Start

### Create New Project

```bash
# Basic usage
~/.claude/configs/scripts/setup-project.sh my-project

# With description and custom packages
~/.claude/configs/scripts/setup-project.sh my-api "REST API service" "api,models,services"
```

### Manual Setup

Copy specific configurations to existing projects:

```bash
# VS Code
cp ~/.claude/configs/vscode/settings.json .vscode/
cp ~/.claude/configs/vscode/markdown-preview.css .vscode/

# Python configs (customize templates first)
cp ~/.claude/configs/python/pyproject.toml.template pyproject.toml
cp ~/.claude/configs/python/ruff.toml.template ruff.toml

# Git
cp ~/.claude/configs/git/.gitignore.template .gitignore
```

## Configuration Details

### VS Code Settings (`vscode/settings.json`)

Comprehensive VS Code configuration including:

- **Python Development**: uv, mypy, ruff integration
- **Markdown**: Custom dark theme, linting, formatting
- **Testing**: pytest integration with discovery
- **Type Checking**: mypy strict mode
- **Code Quality**: ruff for linting and formatting
- **File Exclusions**: Python cache files, build artifacts

### Markdown Preview (`vscode/markdown-preview.css`)

Custom dark theme CSS providing:
- Dark background (#1e1e1e) with light text
- Syntax highlighting for code blocks
- Color-coded headers (teal, blue, yellow)
- Proper table styling with alternating rows
- VS Code-consistent styling

### Python Configuration (`python/pyproject.toml.template`)

XDS Framework standard configuration:
- **Python 3.12+** requirement
- **Core Dependencies**: dynaconf, pydantic, rich, typer, loguru
- **Development Tools**: pytest, mypy, ruff, icecream
- **Build System**: hatchling
- **Testing**: pytest with coverage
- **Package Structure**: configurable package directories

Template variables:
- `{{PROJECT_NAME}}`: Project name
- `{{PROJECT_DESCRIPTION}}`: Project description  
- `{{PACKAGE_DIRS}}`: Comma-separated package directories

### Linting Configuration (`python/ruff.toml.template`)

Comprehensive ruff configuration:
- **Target**: Python 3.12
- **Line Length**: 88 characters
- **Rules**: Security, style, complexity, imports
- **XDS Standards**: single quotes, strict formatting
- **Exclusions**: test-specific and legacy code allowances

### Git Configuration (`git/.gitignore.template`)

Python-focused .gitignore covering:
- Python artifacts (__pycache__, *.pyc)
- Virtual environments (.venv, venv/)
- IDE files (.vscode, .idea)
- Testing artifacts (.pytest_cache, coverage)
- OS-specific files (.DS_Store)
- Environment files (.env*)

## Setup Script Features

The `setup-project.sh` script provides automated project initialization:

### Features
- ✅ **Validation**: Project name format checking
- ✅ **Template Processing**: Automatic variable substitution
- ✅ **Directory Structure**: Package and test directories
- ✅ **Git Integration**: Repository initialization with commit
- ✅ **Python Environment**: uv sync for dependencies
- ✅ **Basic Files**: CLI, tests, README, CLAUDE.md

### Usage Examples

```bash
# Simple project
./setup-project.sh myapp

# Complex project with multiple packages
./setup-project.sh myapi "REST API service" "api,models,services,utils"

# Data processing project  
./setup-project.sh dataproc "Data processing pipeline" "processors,transformers,loaders"
```

### Generated Structure

```
myproject/
├── .vscode/                   # VS Code configuration
│   ├── settings.json
│   ├── extensions.json
│   └── markdown-preview.css
├── myproject/                 # Main package
│   └── __init__.py
├── tests/                     # Test directory
│   └── test_main.py
├── examples/                  # Examples directory
├── vibe/                      # VIBE workflow directory
├── pyproject.toml            # Python configuration
├── ruff.toml                 # Ruff configuration  
├── .editorconfig             # Editor configuration
├── .gitignore                # Git ignore rules
├── cli.py                    # CLI entry point
├── README.md                 # Project documentation
├── CLAUDE.md                 # Claude Code instructions
└── .git/                     # Git repository
```

## Integration with VIBE Workflow

These configurations integrate seamlessly with the VIBE workflow:

- **`/xpyinit`**: Can use setup-project.sh for initialization
- **`/xprd`**: PRDs created in `vibe/` directory
- **`/xspec`**: Features extracted to `vibe/` directory  
- **`/xtasks`**: Tasks generated in `vibe/` directory
- **`/xgo`**: Implementation with proper tooling setup

## Customization

### Adding New Templates

1. Create template files with `{{VARIABLE}}` placeholders
2. Update `setup-project.sh` to handle new variables
3. Document template variables in this README

### Modifying Existing Templates

1. Edit template files in appropriate directories
2. Test with `setup-project.sh` 
3. Update documentation

### Project-Specific Overrides

Each generated project has its own `CLAUDE.md` for project-specific instructions that override these defaults.

## Maintenance

### Updating Configurations

1. **VS Code Settings**: Update based on new extensions/features
2. **Python Dependencies**: Keep versions current in pyproject.toml
3. **Ruff Rules**: Adjust rules based on project experience
4. **Templates**: Add new template variables as needed

### Version Control

The configs directory should be version controlled separately from individual projects to track configuration evolution.

## Standards Compliance

All configurations enforce XDS Framework standards:

- ✅ **Python 3.12+** only
- ✅ **uv** package manager
- ✅ **mypy** strict type checking
- ✅ **ruff** formatting and linting
- ✅ **pytest** with coverage
- ✅ **Rich** for output (no print statements)
- ✅ **Single quotes** for strings
- ✅ **TDD** approach
- ✅ **Security** best practices

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure script is executable
   ```bash
   chmod +x ~/.claude/configs/scripts/setup-project.sh
   ```

2. **Template Variables Not Replaced**: Check template syntax
   ```bash
   grep -n "{{" ~/.claude/configs/python/*.template
   ```

3. **Missing Dependencies**: Install required tools
   ```bash
   # Install uv
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

### Support

For issues with configurations:
1. Check individual project `CLAUDE.md` files
2. Review XDS Framework documentation
3. Test with minimal project setup

---

*Generated and maintained for XDS Framework projects*
*Last updated: 2025-01-14*