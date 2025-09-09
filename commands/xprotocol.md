# xprotocol - Protocol/Plugin Architecture Designer

## Purpose
Design and implement protocol-based architectures with plugin implementations following contract-driven development patterns.

## Process

### 1. Protocol Opportunity Analysis
Identify protocol-based architecture opportunities through:
- Analyze multiple similar implementations
- Identify common behavior patterns across components  
- Map shared contract requirements
- Evaluate substitutability needs
- Consider future extensibility requirements
- Assess complexity vs benefit trade-offs

### 2. Protocol Definition Phase

**Protocol Contract Design**
- Define required methods with clear signatures
- Specify optional methods for extensions
- Document error handling requirements  
- Define data validation contracts
- Establish performance expectations
- Create comprehensive protocol documentation

**Contract Test Creation**  
- Write tests that ALL plugins must pass
- Define behavior specifications, not implementation
- Cover error conditions and edge cases
- Create compliance validation framework
- Document expected behavior patterns

### 3. Reference Plugin Implementation
Build the simplest, most complete plugin first:
- Choose plugin with minimal external dependencies
- Implement all required protocol methods
- Ensure ALL contract tests pass
- Add plugin-specific features that don't break protocol
- Document plugin development patterns
- Validate protocol completeness through implementation

### 4. Protocol Validation Checkpoint
Before proceeding with additional plugins:
- Verify contract tests are comprehensive
- Confirm protocol captures all required behaviors
- Check that reference plugin proves protocol completeness
- Get user confirmation on protocol design
- Make any needed protocol adjustments
- Document lessons learned from reference implementation

### 5. Parallel Plugin Development
Once protocol is validated:
- Implement remaining plugins in parallel
- Ensure each plugin passes ALL contract tests
- Add plugin-specific features appropriately
- Maintain consistent API across all plugins
- Create plugin registry and discovery system
- Build demonstration and CLI tools

## Protocol Architecture Pattern

### File Structure
```
project/
├── protocols/
│   ├── StorageProtocol.py      # Contract definition
│   ├── StorageProtocol.test.py # Contract tests (all plugins must pass)
│   └── AuthProtocol.py         # Additional protocols
├── plugins/
│   ├── storage/
│   │   ├── FileStorage.py      # Reference plugin (build first)
│   │   ├── FileStorage.test.py # Plugin-specific tests
│   │   ├── S3Storage.py        # Additional plugins (parallel)
│   │   └── S3Storage.test.py
│   └── auth/
│       ├── LocalAuth.py
│       └── LocalAuth.test.py
├── registry/
│   ├── PluginRegistry.py       # Plugin management
│   └── PluginRegistry.test.py
└── examples/
    └── demo_protocols.py       # Exhaustive demonstrations
```

## Protocol Definition Template

```python
# protocols/StorageProtocol.py
from abc import ABC, abstractmethod
from typing import Any, Optional, Dict, List

class StorageProtocol(ABC):
    """Storage plugin contract - all storage implementations must support these methods."""
    
    @abstractmethod
    def save(self, key: str, data: Any) -> bool:
        """Save data with given key. Return True if successful."""
        pass
    
    @abstractmethod  
    def load(self, key: str) -> Optional[Any]:
        """Load data by key. Return None if not found."""
        pass
    
    @abstractmethod
    def delete(self, key: str) -> bool:
        """Delete data by key. Return True if existed and deleted."""
        pass
    
    @abstractmethod
    def exists(self, key: str) -> bool:
        """Check if key exists in storage."""
        pass
    
    # Optional methods (plugins may implement)
    def list_keys(self) -> List[str]:
        """List all keys. Optional - may raise NotImplementedError."""
        raise NotImplementedError("Plugin does not support key listing")
```

## Contract Test Template

```python
# protocols/StorageProtocol.test.py
import pytest
from tests.factories import DataFactory

def test_storage_contract(storage_plugin):
    """Contract test that ALL storage plugins must pass."""
    # Test data from factory
    test_data = DataFactory.build()
    key = "test_key"
    
    # Test save
    assert storage_plugin.save(key, test_data) == True
    
    # Test exists  
    assert storage_plugin.exists(key) == True
    
    # Test load
    loaded = storage_plugin.load(key)
    assert loaded == test_data
    
    # Test delete
    assert storage_plugin.delete(key) == True
    assert storage_plugin.exists(key) == False
    assert storage_plugin.load(key) is None

@pytest.mark.parametrize("invalid_key", ["", None, 123])
def test_storage_invalid_keys(storage_plugin, invalid_key):
    """All plugins must handle invalid keys consistently."""
    with pytest.raises(ValueError):
        storage_plugin.save(invalid_key, "data")
```

## Reference Plugin Template

```python
# plugins/storage/FileStorage.py
from pathlib import Path
from typing import Any, Optional, List
import json
from protocols.StorageProtocol import StorageProtocol

class FileStorage(StorageProtocol):
    """Reference file-based storage plugin."""
    
    def __init__(self, base_path: str = "./storage"):
        self.base_path = Path(base_path)
        self.base_path.mkdir(parents=True, exist_ok=True)
    
    def save(self, key: str, data: Any) -> bool:
        if not key or not isinstance(key, str):
            raise ValueError("Key must be non-empty string")
        
        file_path = self.base_path / f"{key}.json"
        try:
            with file_path.open('w') as f:
                json.dump(data, f)
            return True
        except Exception:
            return False
    
    def load(self, key: str) -> Optional[Any]:
        file_path = self.base_path / f"{key}.json"
        try:
            with file_path.open('r') as f:
                return json.load(f)
        except FileNotFoundError:
            return None
    
    def delete(self, key: str) -> bool:
        file_path = self.base_path / f"{key}.json"
        try:
            file_path.unlink()
            return True
        except FileNotFoundError:
            return False
    
    def exists(self, key: str) -> bool:
        file_path = self.base_path / f"{key}.json"
        return file_path.exists()
    
    # Plugin-specific extension
    def list_keys(self) -> List[str]:
        """FileStorage-specific: list all stored keys."""
        return [f.stem for f in self.base_path.glob("*.json")]
```

## Key Principles
- **Protocol First**: Define complete contract before any plugin
- **Contract Tests**: Behavior ALL plugins must support
- **Reference Validates**: Simplest plugin proves protocol completeness
- **Parallel Only After Validation**: Protocol must be proven first
- **Consistent API**: All plugins follow exact protocol
- **Plugin-Specific Features**: Extensions that don't break protocol
- **Interactive Confirmation**: Validate protocol design with user

## Interactive Decision Points
1. **Protocol Scope**: "Does this protocol capture all required behaviors?"
2. **Reference Selection**: "Which plugin should be our reference implementation?"
3. **Protocol Validation**: "Does the reference prove the protocol is complete?"
4. **Before Parallel**: "Protocol validated? Ready to build others in parallel?"
5. **Plugin Extensions**: "Should this plugin-specific feature be in the protocol?"

## Output
- Protocol definitions with comprehensive contracts
- Contract tests that enforce behavioral requirements
- Reference plugin validating protocol completeness
- Additional plugins implementing the same protocol
- Plugin registry and management system
- Exhaustive demonstration and CLI tools

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`