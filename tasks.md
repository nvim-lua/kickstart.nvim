# Neovim Claude Integration - Task Tracking

## Project Overview

Building a Claude Code integration for Neovim that works seamlessly with a tmux-based workflow. The integration will support both interactive Claude sessions and autonomous "background agents" that can work on tasks independently.

## Core Principles

- **Tmux-first**: All Claude interactions happen in tmux panes/windows
- **Non-intrusive**: Doesn't change existing nvim/tmux workflow
- **Git-aware**: Leverages git worktrees for safe parallel development
- **Observable**: Easy to monitor what agents are doing

## Feature Breakdown

### 1. Core Plugin Infrastructure

#### 1.1 Plugin Setup
- [x] Create plugin directory structure (`lua/nvim-claude/`)
- [x] Set up basic plugin module with `setup()` function
- [x] Add configuration options table
- [x] Create plugin entry in `lua/colinzhao/lazy/claude.lua`
- [x] Test: Plugin loads without errors

#### 1.2 Configuration Management
- [x] Define default configuration schema
- [x] Implement config validation
- [x] Support user config overrides
- [x] Add config options for:
  - [x] Tmux pane split direction and size
  - [x] Agent work directory name
  - [x] Git worktree vs full clone preference
  - [x] Auto-gitignore behavior
- [x] Test: Config changes apply correctly

#### 1.3 Utility Functions
- [x] Create tmux interaction module
- [x] Add git operations wrapper (worktree, status, diff)
- [x] Implement filesystem utilities (create dirs, check paths)
- [x] Add logging/debugging functions (vim.notify)
- [x] Test: Each utility function in isolation

### 2. Basic Claude Chat Integration

#### 2.1 Tmux Pane Management
- [x] Function to create new tmux pane
- [x] Function to find existing Claude panes
- [x] Pane naming/identification system
- [x] Handle pane closing/cleanup
- [ ] Test: Can spawn and track tmux panes

#### 2.2 Claude Chat Command
- [x] Implement `:ClaudeChat` command
- [x] Open Claude in configured tmux split
- [x] Reuse existing pane if available
- [x] Pass current file context if requested
- [x] Test: Command opens Claude reliably

#### 2.3 Context Sharing
- [x] `:ClaudeSendBuffer` - Send current buffer
- [x] `:ClaudeSendSelection` - Send visual selection  
- [x] `:ClaudeSendHunk` - Send git hunk under cursor
- [x] Add appropriate context headers
- [x] Test: Each send command works correctly

### 3. Background Agent System

#### 3.1 Agent Work Directory Management
- [x] Create `.agent-work/` in project root
- [x] Auto-add to `.gitignore` if not present
- [x] Generate timestamped subdirectories
- [x] Clean up old agent directories (configurable)
- [x] Test: Directory creation and gitignore updates

#### 3.2 Git Worktree Integration
- [x] Function to create worktree for agent
- [x] Handle worktree naming (avoid conflicts)
- [x] Support fallback to full clone if worktrees unavailable
- [x] Track worktree <-> agent mapping
- [x] Test: Worktree creation and tracking

#### 3.3 Agent Spawning
- [x] Implement `:ClaudeBg <task>` command
- [x] Create agent work directory
- [x] Set up git worktree
- [x] Spawn tmux window/session for agent
- [x] Initialize Claude with task context
- [x] Create mission log file
- [x] Test: Full agent spawn workflow

#### 3.4 Agent Tracking
- [x] Maintain registry of active agents
- [x] Store agent metadata (task, start time, status)
- [x] Persist registry across nvim sessions
- [x] Auto-detect terminated agents
- [x] Test: Registry operations and persistence

### 4. Inline Diff System (NEW - Major Feature)

#### 4.1 Claude Code Hooks Integration
- [x] Pre-tool-use hook for baseline creation
- [x] Post-tool-use hook for diff detection
- [x] Automatic inline diff display for open buffers
- [x] Claude file edit tracking
- [x] Git stash-based baseline management

#### 4.2 Inline Diff Display
- [x] Real-time diff visualization in buffers
- [x] Syntax highlighting for additions/deletions
- [x] Virtual text for removed lines
- [x] Hunk navigation (]h, [h)
- [x] Multi-file diff tracking

#### 4.3 Diff Actions
- [x] Accept hunk (<leader>ia)
- [x] Reject hunk (<leader>ir)
- [x] Accept all hunks (<leader>iA)
- [x] Reject all hunks (<leader>iR)
- [x] Close inline diff (<leader>iq)

#### 4.4 Multi-File Navigation
- [x] Navigate between files with diffs (]f, [f)
- [x] List all files with diffs (<leader>ci)
- [x] Telescope-like file picker
- [x] Show diff status for unopened files
- [x] Auto-show diffs when opening Claude-edited files

#### 4.5 Persistence and State
- [x] Save diff state across Neovim sessions
- [x] Restore inline diffs on startup
- [x] Track baseline references
- [x] Clean state management

### 5. Diff Viewing and Review (Original git-based)

#### 4.1 Fugitive Integration
- [ ] Function to diff agent worktree against main
- [ ] `:ClaudeDiff [agent]` command
- [ ] Support for three-way diffs
- [ ] Quick diff preview in floating window
- [ ] Test: Diff viewing with fugitive

#### 4.2 Alternative Diff Viewers
- [ ] Optional diffview.nvim integration
- [ ] Built-in diff visualization for quick preview
- [ ] Multi-file diff summary
- [ ] Test: Each diff viewer works correctly

#### 4.3 Change Review Workflow
- [ ] List changed files from agent
- [ ] Preview individual file changes
- [ ] Cherry-pick specific changes
- [ ] Bulk apply agent changes
- [ ] Test: Full review workflow

### 6. Telescope Integration

#### 5.1 Agent Browser
- [ ] Custom Telescope picker for agents
- [ ] Show agent status, task, runtime
- [ ] Preview agent mission log
- [ ] Actions: open, diff, terminate
- [ ] Test: Telescope picker functionality

#### 5.2 Agent Work Browser  
- [ ] Browse files in agent worktrees
- [ ] Quick diff against main branch
- [ ] Open files from agent in main nvim
- [ ] Test: File browsing and operations

### 7. Status and Monitoring

#### 6.1 Status Line Integration
- [ ] Component showing active agent count
- [ ] Quick status of current agent
- [ ] Click to open agent picker
- [ ] Test: Status line updates correctly

#### 6.2 Mission Logs
- [ ] Structured log format for agents
- [ ] Log Claude interactions
- [ ] Track file changes
- [ ] Command history
- [ ] Test: Logging functionality

#### 6.3 Notifications
- [ ] Agent completion notifications
- [ ] Error/failure alerts
- [ ] Optional progress notifications
- [ ] Test: Notification system

### 8. Safety and Convenience Features

#### 8.1 Snapshot System
- [ ] Auto-snapshot before applying changes
- [ ] Named snapshots for important states
- [ ] Snapshot browser/restore
- [ ] Test: Snapshot and restore

#### 8.2 Quick Commands
- [x] `:ClaudeKill [agent]` - Terminate agent
- [x] `:ClaudeClean` - Clean up old agents
- [x] `:ClaudeAgents` - Interactive agent manager (switch, diff, kill)
- [x] `:ClaudeDiffAgent` - Review agent changes with diffview
- [x] `:ClaudeResetBaseline` - Reset inline diff baseline
- [x] Test: Each command functions correctly

#### 7.3 Keybindings
- [ ] Default keybinding set
- [ ] Which-key integration
- [ ] User-customizable bindings
- [ ] Test: Keybindings work as expected

### 9. Advanced Features (Phase 2)

#### 8.1 Agent Templates
- [ ] Predefined agent configurations
- [ ] Task-specific prompts
- [ ] Custom agent behaviors
- [ ] Test: Template system

#### 8.2 Multi-Agent Coordination
- [ ] Agent communication system
- [ ] Shared context between agents
- [ ] Agent task dependencies
- [ ] Test: Multi-agent scenarios

#### 8.3 Integration with Other Plugins
- [ ] Harpoon-style agent switching
- [ ] Trouble.nvim for agent issues
- [ ] Oil.nvim for agent file management
- [ ] Test: Each integration

## Implementation Status

### Completed Features
1. ✅ Core infrastructure - Plugin setup, config, utilities
2. ✅ Claude chat integration - All context sharing commands working
3. ✅ Background agent system - Full implementation with registry
4. ✅ Inline diff system - Major feature addition with full accept/reject workflow
5. ✅ Multi-file diff navigation - Complete with keybindings
6. ✅ Claude Code hooks - Automatic diff detection and display
7. ✅ Persistence - Diff state saved across sessions

### In Progress
1. 🔄 Telescope integration for agents
2. 🔄 Status line integration
3. 🔄 Advanced diff viewing (git-based)

### Future Work
1. 📋 Agent templates and behaviors
2. 📋 Multi-agent coordination
3. 📋 Deep plugin integrations
4. 📋 Snapshot system

## Technical Decisions

### Git Strategy
- **Primary**: Git worktrees for speed and efficiency
- **Fallback**: Full clones for compatibility
- **Safety**: Never modify main working directory

### Tmux Integration
- Use `tmux send-keys` for Claude interaction
- Session/window naming for organization
- Preserve user's tmux workflow

### State Management
- Agent registry in `~/.local/share/nvim/claude-agents/`
- Per-project state in `.agent-work/.state/`
- JSON for serialization

### Error Handling
- Graceful degradation (worktree → clone)
- Clear error messages
- Recovery procedures for common issues

## Success Metrics

- [ ] Can spawn background agent in < 3 seconds
- [ ] Agent changes reviewable in < 5 keystrokes  
- [ ] Zero interference with normal nvim workflow
- [ ] Works on macOS and Linux
- [ ] Clear documentation for all features

## Next Steps

1. Review and refine task list
2. Set up development environment
3. Create plugin skeleton
4. Begin Phase 1 implementation

---

*Last Updated: 2025-01-10*
*Status: Feature Complete for v1.0*

## Recent Accomplishments

### Inline Diff System (Major Feature)
- Complete implementation of inline diff visualization
- Real-time accept/reject functionality for individual hunks
- Multi-file navigation and management
- Persistence across Neovim sessions
- Integration with Claude Code hooks for automatic detection

### Background Agents
- Full agent spawning and management system
- Git worktree integration
- Agent registry with persistence
- Mission logging and tracking

### Next Steps for v1.1
- Polish Telescope integration for agent browsing
- Add status line components showing active diffs
- Improve documentation with examples
- Create demo videos showcasing inline diff system
- Add support for partial hunk acceptance

## Background Agent Features (v1.0 Complete)

### Key Improvements
1. **Hook Isolation**: Background agents always run without hooks (no inline diffs)
2. **ClaudeSwitch**: Switch to agent's worktree to chat/give follow-ups (hooks remain disabled)
3. **ClaudeDiffAgent**: Review agent changes using diffview.nvim
4. **Progress Tracking**: Agents can update progress.txt for real-time status updates
5. **Statusline Integration**: Shows active agent count and latest progress
6. **Enhanced Agent Creation UI**: Interactive popup for mission description with fork options

### Usage
- `ClaudeBg` - Opens interactive UI for creating agents with:
  - Multi-line mission description editor
  - Fork options: current branch, main, stash, or any branch
  - Shows what the agent will be based on
- `ClaudeBg <task>` - Quick creation (backwards compatible)
- `ClaudeSwitch [agent]` - Switch to agent's worktree to chat (no inline diffs)
- `ClaudeDiffAgent [agent]` - Review agent changes with diffview
- `ClaudeAgents` - List all agents with progress
- Agents update progress: `echo 'status' > progress.txt`

### Agent Creation Options
- **Fork from current branch**: Default, uses your current branch state
- **Fork from default branch**: Start fresh from your default branch (auto-detects main/master)
- **Stash current changes**: Creates stash of current work, then applies to agent
- **Fork from other branch**: Choose any branch to base agent on

### Smart Branch Detection
The plugin automatically detects your repository's default branch (main, master, etc.) instead of assuming "main", making it compatible with older repositories that use "master".

### Design Philosophy
Background agents are kept simple - they're always background agents with hooks disabled. This avoids complexity around state transitions and keeps the workflow predictable. Use regular `:ClaudeChat` in your main workspace for inline diff functionality.
