# xmvp - MVP Prototype Generator

## Purpose
Generate functional MVP prototypes from PRD documents with professional-grade factory data and interactive demonstrations.

## Process

### 1. PRD Analysis
- Load `mvp-{name}.md` from `mvp/{name}/`
- Extract core features and user stories
- Identify key data models and interactions
- Map MVP scope to essential functionality

### 2. Factory Creation
Generate professional test data factories:
```python
# mvp/{name}/factories/{model}_factory.py
import factory
from factory import Faker, SubFactory
from datetime import datetime, timedelta

class UserFactory(factory.Factory):
    class Meta:
        model = dict

    id = Faker('random_int', min=1000, max=9999)
    username = Faker('user_name')
    email = Faker('email')
    full_name = Faker('name')
    created_at = Faker('date_time_between',
                      start_date='-1y',
                      end_date='now')
    is_active = True
    role = Faker('random_element',
                elements=('admin', 'user', 'moderator'))
```

### 3. MVP Implementation
Create `{name}.py` with:
- **Rich Console Interface**: Beautiful terminal UI
- **Factory-Generated Data**: Realistic test datasets
- **Core Functionality**: Essential features from PRD
- **Interactive Demos**: User can explore features
- **Error Handling**: Graceful failure scenarios

### 4. MVP Structure Template

```python
#!/usr/bin/env python3
"""
MVP Prototype: {Project Name}
Generated from: mvp-{name}.md

Usage: python {name}.py [--demo] [--interactive]
"""

import os
import json
import typer
from typing import Dict, List, Optional, Any
from rich.console import Console
from rich.panel import Panel
from rich.table import Table
from rich.json import JSON
from rich.syntax import Syntax
from rich.prompt import Prompt, Confirm
from datetime import datetime

# Import factories
from factories.user_factory import UserFactory
from factories.product_factory import ProductFactory

app = typer.Typer()
console = Console()

class MVPCore:
    """Core MVP functionality based on PRD requirements."""

    def __init__(self):
        self.users = []
        self.data_store = {}
        self._initialize_demo_data()

    def _initialize_demo_data(self):
        """Generate realistic demo data using factories."""
        self.users = UserFactory.build_batch(5)
        console.print("✅ MVP initialized with factory-generated data")

@app.command()
def demo(
    section: str = typer.Option("all", help="Demo section (all, core, advanced)"),
    interactive: bool = typer.Option(True, help="Interactive mode")
):
    """Run MVP demonstration."""
    mvp = MVPCore()

    console.print(Panel.fit(
        "🚀 {Project} MVP Prototype\n"
        "Based on PRD: mvp-{name}.md",
        style="bold green"
    ))

    if section in ["all", "core"]:
        demo_core_features(mvp, interactive)

    if section in ["all", "advanced"]:
        demo_advanced_features(mvp, interactive)

def demo_core_features(mvp: MVPCore, interactive: bool):
    """Demonstrate core MVP features."""
    console.print(Panel.fit("🎯 Core Features Demo", style="bold blue"))

    # Show user data
    table = Table(title="Generated Users")
    table.add_column("ID")
    table.add_column("Username")
    table.add_column("Email")
    table.add_column("Role")

    for user in mvp.users[:3]:  # Show first 3 users
        table.add_row(
            str(user['id']),
            user['username'],
            user['email'],
            user['role']
        )

    console.print(table)

    if interactive:
        console.print("\n[dim]Press Enter to continue...[/dim]")
        input()

@app.command()
def interactive():
    """Start interactive MVP session."""
    mvp = MVPCore()

    console.print(Panel.fit(
        "🎮 Interactive MVP Session\n"
        "Type 'help' for commands, 'quit' to exit"
    ))

    while True:
        command = Prompt.ask("\nMVP")

        if command.lower() in ['quit', 'exit']:
            break
        elif command.lower() == 'help':
            show_help()
        elif command.lower() == 'users':
            show_users(mvp)
        elif command.lower().startswith('user '):
            user_id = command.split(' ')[1]
            show_user_details(mvp, user_id)
        else:
            console.print("❓ Unknown command. Type 'help' for available commands.")

def show_help():
    """Show available commands."""
    console.print(Panel(
        "Available Commands:\n"
        "• users - List all users\n"
        "• user <id> - Show user details\n"
        "• help - Show this help\n"
        "• quit - Exit interactive mode",
        title="Help"
    ))

if __name__ == "__main__":
    app()
```

### 5. Integration with VIBE Workflow

**File Organization**:
```
mvp/{name}/
├── mvp-{name}.md             # Source PRD
├── {name}.py                 # Main MVP prototype
├── factories/                # Factory definitions
│   ├── __init__.py
│   ├── user_factory.py
│   └── {model}_factory.py
└── test_{name}.py            # MVP tests
```

### 6. MVP Generation Process

1. **Parse PRD**: Extract user stories and core features from `mvp-{name}.md`
2. **Identify Models**: Map data entities from requirements
3. **Generate Factories**: Create realistic data generators
4. **Build MVP Core**: Implement essential functionality as `{name}.py`
5. **Create Demo Interface**: Rich console-based interaction
6. **Add Tests**: Basic validation of MVP functionality

### 7. Professional Data Patterns

**User Data**:
- Realistic names, emails, usernames
- Proper date ranges and relationships
- Role-based access patterns
- Geographic and demographic diversity

**Business Data**:
- Industry-appropriate product catalogs
- Realistic pricing and inventory
- Customer interaction patterns
- Transaction histories with proper sequences

**System Data**:
- Proper UUID generation
- Timestamp sequences
- Status state transitions
- Audit trail patterns

## Key Features

### Rich Console Interface
- Beautiful tables for data display
- Interactive prompts for user input
- Progress indicators for operations
- Color-coded status messages
- JSON pretty-printing for complex data

### Factory-Driven Data
- No hardcoded test data
- Consistent data relationships
- Configurable data volumes
- Realistic edge case scenarios

### MVP Scope Control
- Focus on core user stories only
- Exclude non-essential features
- Demonstrate key value propositions
- Show realistic user workflows

### Interactive Exploration
- Command-line interface for testing
- Real-time data manipulation
- Error scenario demonstration
- Performance characteristic visibility

## Usage Examples

```bash
# Generate MVP from PRD
/xmvp blog-platform

# Run MVP demonstration
python mvp/blog-platform/blog-platform.py --demo

# Start interactive session
python mvp/blog-platform/blog-platform.py interactive

# Run specific demo section
python mvp/blog-platform/blog-platform.py --demo --section=core

# Non-interactive demo
python mvp/blog-platform/blog-platform.py --demo --no-interactive
```

## Output Files

1. **{name}.py** - Main MVP prototype with rich interface
2. **factories/** - Professional data generation
3. **test_{name}.py** - Basic MVP validation tests
4. **README.md** - MVP usage documentation

## Success Criteria

✅ **Functional**: MVP demonstrates core PRD features
✅ **Professional**: Uses factory-generated realistic data
✅ **Interactive**: Rich console interface for exploration
✅ **Testable**: Includes basic validation tests
✅ **Documented**: Clear usage instructions and examples

## Key Principles

- **MVP-First**: Implement only essential features
- **Factory-Driven**: No hardcoded test data
- **Rich Interface**: Beautiful console interactions
- **Realistic Data**: Professional-grade test datasets
- **Interactive**: User can explore functionality
- **PRD-Faithful**: Implements requirements accurately
- **Clean Naming**: Simple file names without prefixes

## Standards References
- **File Formats**: `_shared/file-formats.md` - Document templates
- **VIBE Standards**: `_shared/vibe-standards.md` - Naming conventions
- **Python Standards**: `_shared/python-standards.md` - Code quality
- **Testing Standards**: `_shared/testing-standards.md` - Factory patterns