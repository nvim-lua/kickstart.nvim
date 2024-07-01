if vim.g.vscode then
  local vscode = require 'vscode'
  --n: normal mode, x: visual mode, i: insert mode

  vim.keymap.set({ 'n', 'x' }, '<leader>,', function()
    vscode.action 'workbench.action.showCommands'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader><leader>', function()
    vscode.action 'workbench.action.quickOpen'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>ts', function()
    vscode.action 'workbench.action.toggleSidebarVisibility'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>x', function()
    vscode.action 'workbench.view.explorer'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>wr', function()
    vscode.action 'workbench.action.reloadWindow'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>wq', function()
    vscode.action 'workbench.action.quit'
  end)

  -- find key
  vim.keymap.set({ 'n', 'x' }, '<leader>sf', function()
    vscode.action 'workbench.action.findInFiles'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>sn', function()
    vscode.action 'workbench.action.focusNextSearchResult'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>sp', function()
    vscode.action 'workbench.action.focusPreviousSearchResult'
  end)

  -- document keys
  vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
    vscode.action 'editor.action.formatDocument'
  end)
  vim.keymap.set('n', '<leader>ds', function()
    vscode.action 'cSpell.toggleEnableSpellChecker'
    vscode.call 'workbench.action.quickOpenNavigateNextInEditorPicker'
    vscode.call 'workbench.action.quickOpenNavigateNextInEditorPicker'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>.', function()
    vscode.action 'editor.action.quickFix'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>rn', function()
    vscode.action 'editor.action.rename'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
    vscode.action 'editor.action.refactor'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>ri', function()
    vscode.action 'editor.action.organizeImports'
  end)
  vim.keymap.set('n', 'gd', function()
    vscode.action 'editor.action.revealDefinition'
  end)
  vim.keymap.set('n', 'gi', function()
    vscode.action 'editor.action.goToImplementation'
  end)
  vim.keymap.set('n', 'K', function()
    vscode.action 'editor.action.scrollUpHover'
  end)
  vim.keymap.set('n', '<C-k>', function()
    vscode.action 'editor.action.triggerParameterHints'
  end)
  vim.keymap.set('n', 'gr', function()
    vscode.action 'references-view.findReferences'
  end)
  -- editor.action.findReferences
  vim.keymap.set('n', '[d', function()
    vscode.action 'editor.action.marker.prev'
  end)
  vim.keymap.set('n', ']d', function()
    vscode.action 'editor.action.marker.next'
  end)
  vim.keymap.set('n', '<leader>e', function()
    vscode.action 'workbench.actions.view.problems'
  end)

  -- editor keys
  vim.keymap.set({ 'n', 'x' }, '<leader>ep', function()
    vscode.action 'workbench.action.pinEditor'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>eP', function()
    vscode.action 'workbench.action.unpinEditor'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>es', function()
    vscode.action 'workbench.action.splitEditor'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>ev', function()
    vscode.action 'workbench.action.splitEditorDown'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>et', function()
    vscode.action 'workbench.action.closeOtherEditors'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>el', function()
    vscode.action 'workbench.action.moveEditorLeftInGroup'
  end)
  vim.keymap.set({ 'n', 'x' }, '<leader>el', function()
    vscode.action 'workbench.action.moveEditorRightInGroup'
  end)
  vim.keymap.set({ 'n', 'x' }, 'Q', function()
    vscode.call 'workbench.action.files.save'
    vscode.call 'workbench.action.unpinEditor'
    vscode.action 'workbench.action.closeActiveEditor'
  end)

  -- vscode-harpoon
  vim.keymap.set('n', '<leader>ha', function()
    vscode.action 'vscode-harpoon.addEditor'
  end)
  vim.keymap.set('n', '<leader>hp', function()
    vscode.action 'vscode-harpoon.editorQuickPick'
  end)
  vim.keymap.set('n', '<leader>he', function()
    vscode.action 'vscode-harpoon.editEditors'
  end)
  vim.keymap.set('n', '<leader>h1', function()
    vscode.action 'vscode-harpoon.goToEditor1'
  end)
  vim.keymap.set('n', '<leader>h2', function()
    vscode.action 'vscode-harpoon.goToEditor2'
  end)
  vim.keymap.set('n', '<leader>h3', function()
    vscode.action 'vscode-harpoon.goToEditor3'
  end)
  vim.keymap.set('n', '<leader>h4', function()
    vscode.action 'vscode-harpoon.goToEditor4'
  end)
  vim.keymap.set('n', '<leader>h5', function()
    vscode.action 'vscode-harpoon.goToEditor5'
  end)
end
