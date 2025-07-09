# Claude Integration Development Notes

## Quick Start

1. Check task progress: `./check-tasks.sh`
2. View tasks: `nvim tasks.md`
3. Start implementing: Begin with Phase 1 tasks

## Key Files

- `tasks.md` - Comprehensive task tracking (gitignored)
- `check-tasks.sh` - Progress tracking script (gitignored)
- `lua/nvim-claude/` - Plugin code (to be created)
- `lua/colinzhao/lazy/claude.lua` - Plugin config (to be created)

## Development Workflow

1. Pick a task from `tasks.md`
2. Implement the feature
3. Test it thoroughly
4. Mark task as complete: Change `- [ ]` to `- [x]`
5. Run `./check-tasks.sh` to see progress

## Testing Commands

```bash
# Test plugin loading
nvim -c "echo 'Plugin loaded'" -c "qa"

# Test specific commands (once implemented)
nvim -c "ClaudeChat" 
nvim -c "ClaudeBg 'test task'"
```

## Git Worktree Commands (for reference)

```bash
# List worktrees
git worktree list

# Add new worktree
git worktree add .agent-work/2024-01-15-feature main

# Remove worktree
git worktree remove .agent-work/2024-01-15-feature
```

## Tmux Commands (for reference)

```bash
# Split pane horizontally
tmux split-window -h -p 40

# Name current pane
tmux select-pane -T "claude-chat"

# List panes with names
tmux list-panes -F "#{pane_id} #{pane_title}"

# Send keys to specific pane
tmux send-keys -t %1 "echo 'Hello'" Enter
```

## Architecture Notes

- **Tmux-first**: All Claude interactions in tmux panes
- **Git worktrees**: For agent isolation
- **State management**: JSON files in `.agent-work/.state/`
- **No nvim terminal**: Respect existing workflow

## Current Status

- Phase: Planning → Implementation
- Next: Create plugin skeleton (Task 1.1) 