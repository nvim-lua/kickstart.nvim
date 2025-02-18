# System Architecture & Patterns

## Core Architecture
- Plugin management via lazy.nvim
- LSP-based intellisense and code navigation
- Event-driven configuration loading
- Modular plugin configuration
- Enhanced mode state management system

## Key Design Patterns

1. Mode Management
   - Advanced state persistence
   - Event-driven mode transitions
   - Mode-specific context preservation
   - Pre/post mode change hooks
   - Mode validation system
   - Mode-specific settings store

2. Event System
   - Hierarchical event handling
   - Event queueing mechanism
   - Async event processing
   - Event prioritization
   - Mode-specific event handlers

3. Persistence Layer
   - Versioned state storage
   - State migration system
   - Corruption detection
   - Fallback mechanisms
   - Incremental state updates

4. Integration Patterns
   - Mode-aware plugin system
   - LSP integration with mode context
   - Buffer grouping by mode
   - Window layout persistence
   - Mode-specific UI elements

5. Configuration Patterns
   - Centralized keybinding management
   - Plugin-specific configuration in separate modules
   - Default options set through vim.opt
   - Autocmd groups for event handling
   - Mode-specific settings and behaviors

6. LSP Integration
   - Mason for LSP server management
   - Uniform LSP configuration across languages
   - Shared capabilities for completion
   - Mode-specific language server configurations

7. Component Relationships
   - Mode Manager ↔ Event System
   - Event System ↔ Persistence Layer
   - Mode Manager ↔ Status Line
   - LSP ↔ Mode Context
   - Buffer Groups ↔ Mode State
   - Window Layout ↔ Mode State
   - Plugins ↔ Mode Context

## Implementation Standards
- Lua for all configuration
- Consistent error handling
- Modular plugin organization
- Clear separation of concerns
- Mode-aware functionality
- State validation
- Event-driven architecture
- Robust error recovery
- Configuration versioning
- Context preservation