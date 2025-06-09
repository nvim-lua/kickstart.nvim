# LeetCode.nvim Guide: Solve LeetCode Problems in Neovim

LeetCode.nvim is a powerful plugin that integrates LeetCode directly into your Neovim editor, allowing you to browse, solve, and submit LeetCode problems without leaving your favorite editor.

## Getting Started

1. Open the LeetCode interface with command:

   ```
   :Leet
   ```

2. You'll need to log in to your LeetCode account the first time you run it.

## Basic Commands

- `:Leet` - Opens the main LeetCode menu
- `:Leet daily` - Open today's daily challenge
- `:Leet random` - Get a random problem
- `:Leet list` - Browse all problems
- `:Leet tabs` - Switch between open problems
- `:Leet submit` - Submit current solution
- `:Leet run` - Run current solution with test cases
- `:Leet reset` - Reset the code to default template
- `:Leet lang` - Change programming language for current problem
- `:Leet cookie update` - Update your LeetCode cookie

## Filter Problems

When using `:Leet list` or `:Leet random`, you can filter problems:

- By difficulty: `difficulty=easy/medium/hard`
- By status: `status=ac/notac/todo`
- By tags: `tags=array,string,dp`

Example:

```
:Leet list difficulty=medium status=notac
:Leet random status=todo difficulty=hard
```

## Keybindings Within LeetCode UI

These keys only work within the LeetCode interface and won't conflict with your existing keymaps:

- `q` - Toggle/close panels
- `<CR>` (Enter) - Confirm selection
- `r` - Reset test cases
- `U` - Use a custom test case
- `H` - Focus on test cases panel
- `L` - Focus on results panel

## Tips for Use

1. **Switch Languages**: Use `:Leet lang` to change your programming language for the current problem.

2. **Multiple Problems**: You can have multiple LeetCode problems open in different tabs.

3. **Code Auto-Injection**: Useful imports and boilerplate code are automatically added for common languages.

4. **Description Format**: Problem descriptions are formatted for better readability, including proper markdown rendering.

5. **Efficient Workflow**: LeetCode.nvim caches your progress, making it faster to get back to your problems.

Enjoy solving LeetCode problems without leaving your favorite editor!
