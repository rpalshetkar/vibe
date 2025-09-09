# xgo - Task Implementation Engine

## Purpose
Execute tasks from task list with structured workflow, testing, and commit discipline.

## Process

### 1. Task Selection
- Load tasks from `claudify/[module]/tasks-*.md`
- Show next incomplete task
- Get user confirmation to proceed

### 2. Implementation Protocol
**For each sub-task:**
1. **Plan**: Brief 2-3 line approach
2. **Test First**: Write failing tests (TDD)
   - Use factory-boy for test data generation
   - Define factories in `tests/factories/` directory
   - Avoid duplicating test data across test files
   - Keep tests clean and focused on behavior, not data setup
3. **Implement**: Minimal code to pass tests
4. **Run xpyfix**: Auto-fix quality issues
   - Format with ruff
   - Add missing types
   - Fix imports
   - Ensure coverage
5. **Refactor**: Clean up while tests stay green
6. **Mark Complete**: Update task with `[x]`
7. **Pause**: Wait for user approval ("y" to continue)

### 3. Parent Task Completion
When all sub-tasks done:
1. **Final xpyfix**: Run comprehensive fixes
2. **Test Suite**: Run full test suite
3. **Clean Up**: Remove temporary code/files
4. **Stage**: `git add .` (only if tests pass)
5. **Commit**: Conventional format
   ```bash
   git commit -m "feat: [parent task]" \
              -m "- [key change 1]" \
              -m "- [key change 2]" \
              -m "Task: [task-id] from [PRD]"
   ```
6. **Mark Parent**: Update with `[x]`

### 4. Progress Tracking
- Use TodoWrite tool for sub-task tracking
- Update task file after each completion
- Maintain "Relevant Files" section

## Key Rules
- **One sub-task at a time** - no parallel work
- **Tests first always** - TDD is mandatory
- **Factory-boy for test data** - see `_shared/testing-standards.md`
- **xpyfix after code** - see `_shared/python-standards.md` for quality checks
- **Stop and wait** - user approval between tasks
- **Commit per parent** - not per sub-task
- **Clean commits** - no temporary code

## Task States
- `[ ]` - Pending
- `[x]` - Completed
- `[>]` - In Progress (optional)

## Example Flow
```
1. Show: "Task 2.1: Write user model tests"
2. User: "y"
3. AI: Creates test factories with factory-boy
4. AI: Writes tests using factories, implements code
5. AI: Runs xpyfix (format, types, imports)
6. AI: Marks task [x]
7. AI: "Sub-task complete. Continue? (y/n)"
8. User: "y"
9. AI: Proceeds to 2.2...
```

## Test Data Organization with factory-boy
```python
# tests/factories/__init__.py
from .user_factory import UserFactory
from .product_factory import ProductFactory

# tests/factories/user_factory.py
import factory
from factory import Faker
from models.user import User

class UserFactory(factory.Factory):
    class Meta:
        model = User
    
    username = Faker('user_name')
    email = Faker('email')
    age = Faker('random_int', min=18, max=100)
    is_active = True

# tests/test_user.py
from tests.factories import UserFactory

def test_user_creation():
    # Clean, no data duplication
    user = UserFactory.build()
    assert user.username
    assert '@' in user.email

def test_multiple_users():
    # Generate batch without repetition
    users = UserFactory.build_batch(5)
    assert len(users) == 5
```

## Output
Updates `claudify/[module]/tasks-*.md` with progress

## Standards References
- Python Standards: `_shared/python-standards.md`
- Testing Patterns: `_shared/testing-standards.md`
- File Formats: `_shared/file-formats.md`