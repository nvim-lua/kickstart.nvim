# Flutter & Dart Development

Complete reference for Flutter and Dart development in Neovim.

## Quick Start

1. Open any `.dart` file to activate Flutter tools
2. Select device: `<Space>fd`
3. Run app: `<Space>fr`
4. Hot reload during development: `<Space>fh`

## Essential Keymaps

### App Lifecycle

| Key | Command | Description |
|-----|---------|-------------|
| `<Space>fr` | FlutterRun | Run the app (auto-selects last used device) |
| `<Space>fh` | FlutterReload | Hot reload (faster, preserves state) |
| `<Space>fR` | FlutterRestart | Hot restart (full reload, resets state) |
| `<Space>fq` | FlutterQuit | Stop the running app |

**Workflow**: First time, use `<Space>fd` to select a device, then `<Space>fr` to run. Subsequent runs remember your device.

### Device Management

| Key | Command | Description |
|-----|---------|-------------|
| `<Space>fd` | FlutterDevices | List and select connected devices |
| `<Space>fe` | FlutterEmulators | Launch an emulator |
| `<Space>fa` | FlutterAttach | Attach to an already running app |
| `<Space>fD` | FlutterDetach | Detach from app (keeps it running) |

### Developer Tools

| Key | Command | Description |
|-----|---------|-------------|
| `<Space>ft` | FlutterDevTools | Start Dart DevTools server |
| `<Space>fc` | FlutterCopyProfilerUrl | Copy profiler URL to clipboard |
| `<Space>fo` | FlutterOutlineToggle | Toggle widget tree outline |
| `<Space>fL` | FlutterLogToggle | Show/hide application logs |

**DevTools Workflow**:
1. Run your app: `<Space>fr`
2. Start DevTools: `<Space>ft`
3. Copy profiler URL: `<Space>fc`
4. Open URL in browser for full DevTools experience

### Code Actions & Refactoring

| Key | Command | Description |
|-----|---------|-------------|
| `<Space>.` | Code Actions | Quick actions (like Cmd+. in VS Code) |
| `gra` | Code Actions | Alternative LSP keymap |

**Common Code Actions**:
- Wrap widget with Padding, Center, Column, etc.
- Remove widget (unwrap)
- Extract widget to new class
- Extract method
- Add import
- Organize imports

### LSP & Language Server

| Key | Command | Description |
|-----|---------|-------------|
| `<Space>fl` | FlutterLspRestart | Restart Dart language server |
| `K` | Hover | Show documentation |
| `grd` | Go to Definition | Jump to definition |
| `grr` | Go to References | Find all references |
| `grn` | Rename | Rename symbol |

## Flutter-Specific Features

### Widget Tree Outline

The outline window shows your widget tree structure:

```
<Space>fo  # Toggle outline window
```

The outline updates as you edit and shows:
- Widget hierarchy
- Widget types
- Quick navigation to widgets

### Closing Tags

Automatically shows closing tags for deeply nested widgets:

```dart
Container(                    // Container
  child: Column(              // Column
    children: [
      Text('Hello'),
      Text('World'),
    ],
  ),                          // Column
),                            // Container
```

### Color Preview

Material Design colors show inline preview:

```dart
Colors.red                    # Shows red color indicator
Color(0xFF42A5F5)            # Shows the actual color
```

### Hot Reload vs Hot Restart

| Hot Reload (`<Space>fh`) | Hot Restart (`<Space>fR`) |
|---------------------------|---------------------------|
| Fast (< 1 second) | Slower (few seconds) |
| Preserves app state | Resets app state |
| UI changes only | Can handle code structure changes |
| Use during active development | Use after changing initState, constructors |

## Debugging

### Debug Keymaps

Available when debugging (after `<F5>` or breakpoint hit):

| Key | Description |
|-----|-------------|
| `F5` | Start/Continue |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `<Space>db` | Toggle breakpoint |
| `<Space>dB` | Conditional breakpoint |
| `<Space>dt` | Terminate debug session |
| `<Space>dr` | Toggle REPL |
| `<Space>du` | Toggle debug UI |

### Debug Workflow

1. Set breakpoints: Position cursor, press `<Space>db`
2. Start debugging: `F5` (launches app in debug mode)
3. App pauses at breakpoint
4. Inspect variables in debug UI panels
5. Step through code: `F10`, `F11`, `F12`
6. Continue execution: `F5`

### Debug UI Panels

When debugging starts, you get:
- **Scopes**: Local and global variables
- **Breakpoints**: All breakpoints in your project  
- **Call Stack**: Function call hierarchy
- **Watches**: Custom expressions to monitor
- **REPL**: Evaluate Dart expressions live
- **Console**: Debug output and print statements

## Logs

```
<Space>fL   # Toggle log buffer
```

The log buffer shows:
- `print()` statements
- Flutter framework messages
- Hot reload/restart confirmations
- Error messages and stack traces

## Tips & Tricks

### Fast Development Loop

```
1. Make UI changes
2. <Space>fh for instant hot reload
3. See changes immediately
4. Repeat
```

### When Hot Reload Fails

If hot reload shows unexpected behavior:

```
<Space>fR   # Hot restart (full reload)
```

If issues persist:

```
<Space>fq   # Quit app
<Space>fl   # Restart LSP
<Space>fr   # Run again
```

### Multiple Devices

Switch between devices without restarting:

```
<Space>fq   # Quit current
<Space>fd   # Select new device
<Space>fr   # Run on new device
```

### Widget Extraction

To extract a widget to a new class:

1. Visual select the widget code
2. Press `<Space>.` or `gra`
3. Choose "Extract Widget"
4. Enter new widget name

### Attach to Running App

If your app is already running (started outside Neovim):

```
<Space>fa   # Attach to running process
```

This enables hot reload and debugging for external apps.

## Configuration

Flutter tools are configured in `lua/custom/plugins/flutter.lua`.

Key settings:
- **Auto-start DevTools**: `dev_tools.autostart = false` (manual start)
- **Widget guides**: `widget_guides.enabled = true` (visual nesting guides)
- **Closing tags**: `closing_tags.enabled = true` (shows widget closing comments)
- **Color preview**: `lsp.color.enabled = true` (inline color indicators)

## Troubleshooting

### LSP Not Working

```
:FlutterLspRestart
# or
<Space>fl
```

### Can't Select Device

Ensure Flutter can see your devices:

```
:!flutter devices
```

If devices don't show, check:
- Android emulator is running
- iOS simulator is running  
- Physical device is connected and authorized
- Chrome is installed (for web)

### Hot Reload Not Responding

```
<Space>fR   # Force hot restart
```

If still not working:

```
<Space>fq   # Quit
<Space>fr   # Restart fresh
```

### Dart Analysis Errors

Force re-analysis:

```
:FlutterReanalyze
```

Or restart LSP: `<Space>fl`

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [flutter-tools.nvim GitHub](https://github.com/akinsho/flutter-tools.nvim)

## See Also

- [Debug Keymaps](../keymaps/README.md#debugging) - Complete debugging reference
- [LSP Features](../plugins/lsp.md) - Language Server Protocol features
- [Code Actions](../keymaps/README.md#lsp) - All code action keymaps
