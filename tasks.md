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
- [ ] Define default configuration schema
- [ ] Implement config validation
- [ ] Support user config overrides
- [ ] Add config options for:
  - [ ] Tmux pane split direction and size
  - [ ] Agent work directory name
  - [ ] Git worktree vs full clone preference
  - [ ] Auto-gitignore behavior
- [ ] Test: Config changes apply correctly

#### 1.3 Utility Functions
- [x] Create tmux interaction module
- [x] Add git operations wrapper (worktree, status, diff)
- [x] Implement filesystem utilities (create dirs, check paths)
- [ ] Add logging/debugging functions
- [ ] Test: Each utility function in isolation

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
- [ ] Pass current file context if requested
- [ ] Test: Command opens Claude reliably

#### 2.3 Context Sharing
- [x] `:ClaudeSendBuffer` - Send current buffer
- [x] `:ClaudeSendSelection` - Send visual selection  
- [ ] `:ClaudeSendHunk` - Send git hunk under cursor
- [x] Add appropriate context headers
- [ ] Test: Each send command works correctly

### 3. Background Agent System

#### 3.1 Agent Work Directory Management
- [ ] Create `.agent-work/` in project root
- [ ] Auto-add to `.gitignore` if not present
- [ ] Generate timestamped subdirectories
- [ ] Clean up old agent directories (configurable)
- [ ] Test: Directory creation and gitignore updates

#### 3.2 Git Worktree Integration
- [ ] Function to create worktree for agent
- [ ] Handle worktree naming (avoid conflicts)
- [ ] Support fallback to full clone if worktrees unavailable
- [ ] Track worktree <-> agent mapping
- [ ] Test: Worktree creation and tracking

#### 3.3 Agent Spawning
- [x] Implement `:ClaudeBg <task>` command
- [x] Create agent work directory
- [x] Set up git worktree
- [x] Spawn tmux window/session for agent
- [ ] Initialize Claude with task context
- [x] Create mission log file
- [ ] Test: Full agent spawn workflow

#### 3.4 Agent Tracking
- [ ] Maintain registry of active agents
- [ ] Store agent metadata (task, start time, status)
- [ ] Persist registry across nvim sessions
- [ ] Auto-detect terminated agents
- [ ] Test: Registry operations and persistence

### 4. Diff Viewing and Review

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

### 5. Telescope Integration

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

### 6. Status and Monitoring

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

### 7. Safety and Convenience Features

#### 7.1 Snapshot System
- [ ] Auto-snapshot before applying changes
- [ ] Named snapshots for important states
- [ ] Snapshot browser/restore
- [ ] Test: Snapshot and restore

#### 7.2 Quick Commands
- [ ] `:ClaudeKill [agent]` - Terminate agent
- [ ] `:ClaudeClean` - Clean up old agents
- [ ] `:ClaudeSwitch [agent]` - Switch to agent tmux
- [ ] Test: Each command functions correctly

#### 7.3 Keybindings
- [ ] Default keybinding set
- [ ] Which-key integration
- [ ] User-customizable bindings
- [ ] Test: Keybindings work as expected

### 8. Advanced Features (Phase 2)

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

## Implementation Phases

### Phase 1: MVP (Week 1-2)
1. Core infrastructure (1.1-1.3)
2. Basic Claude chat (2.1-2.3)
3. Simple agent spawning (3.1-3.3)
4. Basic diff viewing (4.1)

### Phase 2: Core Features (Week 3-4)
1. Agent tracking (3.4)
2. Full diff/review workflow (4.2-4.3)
3. Telescope integration (5.1-5.2)
4. Basic monitoring (6.1-6.2)

### Phase 3: Polish (Week 5-6)
1. Safety features (7.1-7.2)
2. Keybindings and UX (7.3)
3. Notifications (6.3)
4. Documentation and tests

### Phase 4: Advanced (Future)
1. Agent templates (8.1)
2. Multi-agent features (8.2)
3. Deep plugin integrations (8.3)

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

*Last Updated: [Current Date]*
*Status: Planning Phase* 
