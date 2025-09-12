# xdemo - Interactive Demo Generator

## Purpose
Create interactive demo scripts that showcase module functionality with rich console output, pagination, and @demoable decorators. **Emphasizes data organization and reusable components to prevent code bloat and maintain clean architecture.**

## Process

### 1. Demo Discovery Phase
- Scan target module for functions with @demoable decorators
- Identify key functionality and user-facing features
- Map demo scenarios based on module's purpose and capabilities
- Determine logical groupings for sectioned demonstrations

### 2. Demo Script Generation
Create comprehensive demo script following established patterns:
- **Use Typer CLI framework** for command-line interface
- **Rich Console output** for beautiful terminal displays  
- **Smart pagination** - pause between sections for user interaction
- **JSON output formatting** instead of debug logs
- **Code snippet examples** showing actual usage
- **Error handling demonstrations** for edge cases

### 3. Demo Structure Template

```python
#!/usr/bin/env python3
"""
Interactive demo for {module} module.

Usage: python demo_{module}.py [options]
"""

import os
import typer
from rich.console import Console
from rich.panel import Panel
from rich.syntax import Syntax
from rich.json import JSON
import json

from {module} import {functions}
from tests.factories import {Factory}

app = typer.Typer()
console = Console()

# Global interactive mode flag
INTERACTIVE_MODE = True

@app.command()
def demo(
    section: str = typer.Option("all", help="Demo section to run (all, basic, advanced)"),
    interactive: bool = typer.Option(None, "--interactive/--no-interactive", "-i", help="Pause between sections (default: True, override with INTERACTIVE env var)")
):
    """Run interactive demo for {module}."""
    
    # Set global interactive mode - check env var first, then command line arg
    global INTERACTIVE_MODE
    if interactive is not None:
        INTERACTIVE_MODE = interactive
    else:
        # Check environment variable, default to True if not set
        env_interactive = os.getenv("INTERACTIVE", "true").lower()
        INTERACTIVE_MODE = env_interactive in ("true", "1", "yes", "on")
    
    if section in ["all", "basic"]:
        demo_basic_usage()
        
    if section in ["all", "advanced"]:
        demo_advanced_features()
        
    if section in ["all", "error"]:
        demo_error_handling()

def demo_basic_usage():
    """Demonstrate basic module functionality."""
    console.print(Panel.fit("🚀 Basic Usage Demo", style="bold green"))
    
    # Show code example
    code = '''
from {module} import {function}
from tests.factories import {Factory}

# Generate test data with factory-boy
data = {Factory}.build()
result = {function}(data)
'''
    console.print(Syntax(code, "python", theme="monokai"))
    
    # Execute and show results
    data = {Factory}.build()
    result = {function}(data)
    
    console.print("📊 Result:")
    console.print(JSON(json.dumps(result, indent=2)))
    
    pause_for_user()

def pause_for_user():
    """Smart pagination - wait for user input if in interactive mode."""
    if INTERACTIVE_MODE:
        console.print("\n[dim]Press Enter to continue...[/dim]")
        input()
    else:
        console.print("\n[dim]Continuing automatically...[/dim]")

if __name__ == "__main__":
    app()
```

### 4. Demo Content Organization

**Section Types**:
- **Basic Usage**: Core functionality demonstration
- **Advanced Features**: Complex scenarios and edge cases
- **Error Handling**: How module handles invalid inputs
- **Performance**: Benchmarking critical operations (optional)
- **Integration**: How module works with others (optional)

**Output Standards**:
- Use Rich Console for all output formatting
- Show pretty JSON instead of raw debug statements
- Include actual code snippets users can copy
- Demonstrate real data using factory-boy patterns
- Keep console output clean and professional

### 5. Integration Requirements

**File Location**: Always save demo files as `demos/demo_{module}.py`

**CLI Integration**: Link to VIBE system via `xds demo {module}` command with support for `--interactive/--no-interactive` flags

**Dependencies**: 
- Typer for CLI framework
- Rich for console formatting
- Factory-boy for test data
- JSON for pretty output formatting

## Demo Script Pattern Examples

### Basic Function Demo
```python
def demo_user_creation():
    console.print(Panel.fit("👤 User Creation Demo"))
    
    # Show the code
    code = '''user_data = UserFactory.build()
user = create_user(user_data)'''
    console.print(Syntax(code, "python"))
    
    # Execute with factory data
    user_data = UserFactory.build()
    user = create_user(user_data)
    
    console.print("✅ Created user:")
    console.print(JSON(user.to_dict()))
```

### Error Handling Demo
```python
def demo_validation_errors():
    console.print(Panel.fit("⚠️ Error Handling Demo"))
    
    # Show invalid data scenario
    invalid_data = {"email": "invalid-email"}
    
    try:
        user = create_user(invalid_data)
    except ValidationError as e:
        console.print("❌ Validation Error (expected):")
        console.print(JSON({"error": str(e)}))
```

## Key Principles
- **Flexible pagination**: User controls demo flow with `--interactive/--no-interactive` flags
- **Rich visual output**: Use Rich console for beautiful formatting  
- **Factory-based data**: No hardcoded test data in demos
- **Real code examples**: Show actual usage patterns users can copy
- **Error demonstrations**: Show how edge cases are handled
- **Section organization**: Logical groupings with clear navigation
- **JSON output**: Pretty formatted results, not debug logs
- **Environment variable support**: Can use `INTERACTIVE=false` environment variable as alternative to `--no-interactive`

## Usage Examples

```bash
# Run full interactive demo (default - pauses between sections)
python demos/demo_auth.py

# Run specific demo section interactively
python demos/demo_auth.py --section=basic

# Run demo without pauses (continuous mode)
python demos/demo_auth.py --no-interactive

# Using environment variable for non-interactive mode
INTERACTIVE=false python demos/demo_auth.py

# Environment variable with specific section
INTERACTIVE=0 python demos/demo_auth.py --section=basic

# Via VIBE command system
xds demo auth
xds demo auth --no-interactive
INTERACTIVE=false xds demo auth
```

## Output
- Interactive demo script at `demos/demo_{module}.py`
- Rich console output with proper formatting
- Sectioned demonstrations with user-controlled pacing
- Integration with module's @demoable decorated functions
- Copy-pasteable code examples for end users

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`
