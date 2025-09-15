# /xdemo - Generate Interactive Demos

## Purpose
Create interactive demonstration files for module features by scanning code, generating YAML demo snippets, and producing rich console output recordings.

## Usage
```bash
/xdemo <module_name>
```

## What It Does

1. **Scans Module**: Analyzes the specified module and identifies features/functions
2. **Creates Demo Structure**: Sets up organized demo directory structure
3. **Generates YAML Snippets**: Creates self-contained demo snippets for each feature
4. **Validates Output**: Runs code and verifies actual output matches expected output
5. **Records Rich Console**: Generates HTML files with rich console output recordings

## Directory Structure

The command creates demos following this structure:

```
demos/
├── {module}/                    # Module-specific demos
│   ├── {module}.html           # Rich console output recording
│   ├── snippets/               # YAML demo snippets
│   │   ├── {feature1}.yaml
│   │   ├── {feature2}.yaml
│   │   └── {featureN}.yaml
│   ├── fixtures/               # Static test data
│   │   ├── sample_data.json
│   │   └── config_data.yaml
│   └── factories/              # Dynamic data generators
│       └── factory.py
```

## YAML Snippet Format

Each demo snippet is completely self-contained:

```yaml
title: "Feature Name"
description: "Brief description of what this demonstrates"
category: "feature_category"
complexity: "basic|intermediate|advanced"
tags: ["tag1", "tag2", "tag3"]
duration: "X minutes"

documentation: |
  Detailed explanation of the feature being demonstrated.
  Include usage patterns and best practices.

code: |
  from module.feature import function
  from pathlib import Path
  import json

  # Load test data from fixtures
  fixtures_dir = Path(__file__).parent.parent / "fixtures"
  data = json.loads((fixtures_dir / "sample_data.json").read_text())

  # Demonstrate the feature
  result = function(data)
  console.print(f"Input: {data}")
  console.print(f"Result: {result}")

expected_output: |
  Input: {'key': 'value'}
  Result: {'processed': 'value'}

fixtures_used:
  - "fixtures/sample_data.json"

key_points:
  - "Main concept being demonstrated"
  - "Important usage note"
  - "Best practice or tip"
```

## Key Features

- **Rich Console Output**: All demos use rich console for formatted output
- **Self-Contained**: Each snippet includes all necessary imports and data
- **Validated**: Code execution is verified against expected output
- **Organized**: Clear categorization and tagging system
- **Reproducible**: Includes fixtures and factories for consistent data

## Integration

The command integrates with `@demoable/cli.py` to:
- Discover module features and subcommands
- Execute demo code and capture output
- Generate rich console HTML recordings
- Validate actual vs expected output

## Error Handling

If actual output doesn't match expected output:
- Reports specific differences
- Shows both actual and expected results
- Suggests fixes for discrepancies
- Fails gracefully with clear error messages

