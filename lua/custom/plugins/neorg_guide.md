# Neorg Guide: Organized Note-Taking for Neovim

Neorg is a powerful tool for structured note-taking, project and task management, time tracking, and more, all within Neovim. This guide will help you get started with the basics and highlight advanced features.

## Getting Started

To start using Neorg:

1. Make sure `luarocks` is installed on your system:

   ```bash
   sudo pacman -S luarocks
   # Or using yay if it's not in the main repos
   # yay -S luarocks
   ```

2. Create your first Neorg file:

   ```
   :e notes.norg
   ```

3. Initialize your workspace directories if they don't exist:
   ```bash
   mkdir -p ~/notes ~/work/notes ~/personal/notes ~/projects/notes
   ```

## Key Concepts

### Workspaces

Workspaces are directories where your Neorg files are stored. Your configuration includes:

- `notes`: Your general notes (~/notes)
- `work`: Work-related notes (~/work/notes)
- `personal`: Personal notes (~/personal/notes)
- `projects`: Project-specific notes (~/projects/notes)

### Keybinding Structure

All Neorg keybindings start with `<Leader>n` (usually `\n` or `<Space>n` depending on your leader key) to avoid conflicts with your existing bindings.

#### Navigation & Workspaces

- `<Leader>nw` - Open workspace selector
- `<Leader>nn` - Switch to notes workspace
- `<Leader>nwp` - Switch to personal workspace
- `<Leader>nl` - Return to last workspace

#### Journal

- `<Leader>nj` - Open today's journal
- `<Leader>nyt` - Open yesterday's journal
- `<Leader>ntm` - Open tomorrow's journal
- `<Leader>nwd` - Go to day view in journal
- `<Leader>nwm` - Go to month view in journal

#### Document Manipulation

- `<Leader>ntt` - Generate table of contents
- `<Leader>ni` - Inject metadata
- `<Leader>nm` - Update metadata
- `<Leader>nc` - Toggle concealer
- `<Leader>nil` - Insert link
- `<Leader>nid` - Insert date

#### Export Commands

- `<Leader>nem` - Export to Markdown

#### Advanced List Manipulation

- `<Leader>nu` - Iterate to next list type (cycle through bullet types/numbers)
- `<Leader>np` - Iterate to previous list type

### Basic Syntax

```norg
* Heading 1
** Heading 2
*** Heading 3

- Unordered list
  - Nested item
    - More nesting

1. Ordered list
2. Second item

~ Definition list
  Term 1 :: Definition 1
  Term 2 :: Definition 2
~

( ) Undone task
(x) Completed task
(?) Pending task
(!) Important task
(-) Pending task
(=) Recurring task
(+) On hold task

`inline code`

@code lua
print("Hello from Neorg!")
@end

{https://github.com/nvim-neorg/neorg}[Link to Neorg]

> This is a quote
> It can span multiple lines

$ E = mc^2 $ -- Inline math

@math
f(x) = \int_{-\infty}^\infty
    \hat f(\xi)\,e^{2 \pi i \xi x}
    \,d\xi
@end
```

## Command Reference

### Common Commands

| Command                     | Description                     |
| --------------------------- | ------------------------------- |
| `:Neorg workspace notes`    | Switch to notes workspace       |
| `:Neorg journal today`      | Open today's journal            |
| `:Neorg toc`                | Generate a table of contents    |
| `:Neorg export to-markdown` | Export current file to markdown |
| `:Neorg toggle-concealer`   | Toggle the concealer on/off     |
| `:Neorg return`             | Return to the last workspace    |

### Advanced Commands

| Command                             | Description                      |
| ----------------------------------- | -------------------------------- |
| `:Neorg inject-metadata`            | Add metadata to current document |
| `:Neorg update-metadata`            | Update document metadata         |
| `:Neorg journal template`           | Create/edit journal template     |
| `:Neorg keybind all`                | Show all available keybindings   |
| `:Neorg modules list`               | List all loaded modules          |
| `:Neorg generate-workspace-summary` | Generate workspace summary       |

## Advanced Features

### Journal Management

Your journal is configured with a flat structure in the `~/notes/journal` directory:

```
:Neorg journal today     # Open today's journal
:Neorg journal yesterday # Open yesterday's journal
:Neorg journal tomorrow  # Open tomorrow's journal
```

Use `<Leader>nj` for quick access to today's journal.

### Export Options

Export to different formats for sharing:

```vim
:Neorg export to-markdown       " Basic markdown export
:Neorg export to-markdown all   " Export with all extensions
```

The export includes version info with timestamps in the filename format.

### Table of Contents

Generate and use a table of contents with `<Leader>ntt` or `:Neorg toc`.
The TOC is interactive - you can navigate to any section by selecting it.

### Presenter Mode

Turn your notes into presentations:

```vim
:Neorg presenter start  " Start presenter mode
```

Navigate slides with:

- `j/k` or arrow keys - Next/previous slide
- `q` - Exit presenter

## Tips for Best Experience

> 📌 **Note**: A comprehensive keybinding reference is available in the file:
> `/home/kali/.config/nvim/lua/custom/plugins/neorg_keymaps_reference.md`

1. **Create workspace directories** before using them:

   ```bash
   mkdir -p ~/notes ~/work/notes ~/personal/notes ~/projects/notes
   ```

2. **Set conceallevel** for a better visual experience:

   ```vim
   :set conceallevel=2
   ```

3. **Use the journal** for daily notes and tracking with the `<Leader>nj` shortcut.

4. **Follow links** by placing cursor on a link and pressing `<Enter>`.

5. **Export to other formats** when needed to share your notes with `<Leader>nem`.

6. **Use folding** to collapse and expand sections:

   - `za` - Toggle fold under cursor
   - `zR` - Open all folds
   - `zM` - Close all folds

7. **Use custom keybindings** to streamline your workflow - all under the `<Leader>n` prefix.

8. **Check Neorg health** if you encounter issues:

   ```vim
   :checkhealth neorg
   ```

9. **Use calendar navigation** for journal entries:

   ```vim
   :Neorg journal calendar
   ```

   Navigate with arrow keys and press Enter on a date.

10. **Create summaries** of your notes:
    ```vim
    :Neorg generate-summary
    ```

## Advanced Document Structure

### Metadata

Add metadata to documents for better organization:

```norg
@document.meta
title: Project Planning
description: Strategic planning document for Q3 2025
authors: [your_name]
categories: [planning, strategy]
created: 2025-06-09
version: 1.0
@end
```

### Cross-Linking

Create links between your notes:

```norg
{:my-other-file:}[Link to another file]
{:my-other-file:*some-heading}[Link to specific heading]
{* My Heading}[Link to heading in current file]
```

### Advanced Tasks

Track tasks with metadata:

```norg
(x) Completed task #project @tag <2025-06-01>
( ) Upcoming task #work @important <2025-06-15>
(!) Critical task with ^high^ priority
```

### Code Execution

Some code blocks can be executed directly from Neorg:

```norg
@code lua runnable
print("Hello from Neorg!")
@end
```

Use `<Leader>re` to run the code block under your cursor.

## Customization

Your Neorg setup is configured with:

- Diamond icon preset for better visuals
- Custom keybindings under `<Leader>n` prefix
- Four configured workspaces
- Enhanced journal capabilities

Refer to the full configuration in `/home/kali/.config/nvim/lua/custom/plugins/neorg.lua` for more details.
:Neorg export to-markdown

```

## Compatibility

Neorg is designed to work alongside your existing Neovim setup without conflicts. All keymaps are scoped to `.norg` files to avoid conflicts with other plugins.

## Learning More

Visit the [Neorg Wiki](https://github.com/nvim-neorg/neorg/wiki) for comprehensive documentation on all modules and features.
```
