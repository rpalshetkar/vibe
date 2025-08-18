#!/bin/bash

# XDS Framework Project Setup Script
# Usage: setup-project.sh <project_name> [project_description] [package_dirs]

set -e

# Configuration
CONFIGS_DIR="$HOME/.claude/configs"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Validate arguments
if [ $# -lt 1 ]; then
    log_error "Usage: $0 <project_name> [project_description] [package_dirs]"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_DESCRIPTION="${2:-$PROJECT_NAME - XDS Framework Project}"
PACKAGE_DIRS="${3:-$PROJECT_NAME}"

# Validate project name
if [[ ! "$PROJECT_NAME" =~ ^[a-z][a-z0-9_-]*$ ]]; then
    log_error "Project name must start with a letter and contain only lowercase letters, numbers, underscores, and hyphens"
    exit 1
fi

# Check if directory already exists
if [ -d "$PROJECT_NAME" ]; then
    log_warning "Directory '$PROJECT_NAME' already exists. Continue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        log_info "Aborted."
        exit 0
    fi
fi

log_info "Setting up XDS Framework project: $PROJECT_NAME"
log_info "Description: $PROJECT_DESCRIPTION"
log_info "Package directories: $PACKAGE_DIRS"

# Create project structure
mkdir -p "$PROJECT_NAME"/{.vscode,tests,examples,claudify}
cd "$PROJECT_NAME"

# Create package directories
IFS=',' read -ra DIRS <<< "$PACKAGE_DIRS"
for dir in "${DIRS[@]}"; do
    dir=$(echo "$dir" | xargs)  # trim whitespace
    mkdir -p "$dir"
    touch "$dir/__init__.py"
done

# Copy and customize VS Code configurations
log_info "Setting up VS Code configuration..."
cp "$CONFIGS_DIR/vscode/settings.json" .vscode/
cp "$CONFIGS_DIR/vscode/markdown-preview.css" .vscode/
sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$CONFIGS_DIR/vscode/extensions.json.template" > .vscode/extensions.json
log_success "VS Code configuration created"

# Copy and customize Python configurations
log_info "Setting up Python configuration files..."
sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{PROJECT_DESCRIPTION}}/$PROJECT_DESCRIPTION/g" \
    -e "s/{{PACKAGE_DIRS}}/$PACKAGE_DIRS/g" \
    "$CONFIGS_DIR/python/pyproject.toml.template" > pyproject.toml

sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{PACKAGE_DIRS}}/$PACKAGE_DIRS/g" \
    "$CONFIGS_DIR/python/ruff.toml.template" > ruff.toml

cp "$CONFIGS_DIR/python/mypy.ini.template" mypy.ini
cp "$CONFIGS_DIR/python/.editorconfig.template" .editorconfig
log_success "Python configuration files created"

# Copy and customize Git configuration
log_info "Setting up Git configuration..."
sed "s/{{PROJECT_SPECIFIC_IGNORES}}/# Add project-specific ignores here/g" \
    "$CONFIGS_DIR/git/.gitignore.template" > .gitignore
log_success "Git configuration created"

# Create basic project files
log_info "Creating basic project files..."

# Create main CLI file
cat > cli.py << EOF
"""CLI entry point for $PROJECT_NAME."""
from __future__ import annotations

import typer
from rich.console import Console

app = typer.Typer(help="$PROJECT_NAME CLI")
console = Console()


@app.command()
def hello(name: str = "World") -> None:
    """Say hello to someone."""
    console.print(f"Hello, [bold blue]{name}[/bold blue]!")


def main() -> None:
    """Main entry point."""
    app()


if __name__ == "__main__":
    main()
EOF

# Create basic test file
mkdir -p tests
cat > tests/test_main.py << EOF
"""Tests for $PROJECT_NAME."""
from __future__ import annotations

import pytest


def test_placeholder() -> None:
    """Placeholder test."""
    assert True
EOF

# Create basic README
cat > README.md << EOF
# $PROJECT_NAME

$PROJECT_DESCRIPTION

## Installation

\`\`\`bash
uv sync
\`\`\`

## Usage

\`\`\`bash
uv run $PROJECT_NAME --help
\`\`\`

## Development

\`\`\`bash
# Install dependencies
uv sync --dev

# Run tests
uv run pytest

# Run linting
uv run ruff check .

# Format code
uv run ruff format

# Type checking
uv run mypy .
\`\`\`

## Architecture

This project follows the XDS Framework standards:

- Python 3.12+
- Type safety with mypy strict mode
- Code quality with ruff
- Testing with pytest
- Rich CLI interfaces
- Pydantic for validation

## License

MIT
EOF

# Create CLAUDE.md for project-specific instructions
cat > CLAUDE.md << EOF
# CLAUDE.md

This file provides guidance to Claude Code when working with the $PROJECT_NAME project.

## Overview

$PROJECT_DESCRIPTION

## Architecture

This project follows XDS Framework standards:
- Python 3.12+ with strict type checking
- Pydantic for data validation
- Rich for CLI interfaces
- Pytest for testing with 100% coverage goal

## Key Commands

\`\`\`bash
# Run tests
uv run pytest

# Type checking
uv run mypy .

# Linting
uv run ruff check .

# Format code
uv run ruff format

# Run CLI
uv run $PROJECT_NAME --help
\`\`\`

## Development Guidelines

- Follow TDD: write tests first
- Maintain type safety
- Use rich for output, never print()
- Follow existing patterns
- Update tests before implementation
EOF

log_success "Basic project files created"

# Initialize git repository
if command -v git &> /dev/null; then
    log_info "Initializing Git repository..."
    git init
    git add .
    git commit -m "feat: initial project setup with XDS Framework standards

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
    log_success "Git repository initialized with initial commit"
else
    log_warning "Git not found. Skipping repository initialization."
fi

# Initialize Python environment
if command -v uv &> /dev/null; then
    log_info "Initializing Python environment with uv..."
    uv sync --dev
    log_success "Python environment initialized"
else
    log_warning "uv not found. Please install uv and run 'uv sync --dev' manually."
fi

log_success "Project '$PROJECT_NAME' setup complete!"
log_info ""
log_info "Next steps:"
log_info "1. cd $PROJECT_NAME"
log_info "2. uv run $PROJECT_NAME --help"
log_info "3. Start coding with TDD approach"
log_info "4. Use /xprd, /xspec, /xtasks, /xgo workflow for structured development"