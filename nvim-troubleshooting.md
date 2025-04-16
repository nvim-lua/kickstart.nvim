# Troubleshooting Notes for Neovim Setup

- Check generate health of Neovim setup. `:checkhealth`
- Update Treesitter. `:TSUpdate`
- Check LSP installation. `:Mason`
- Fix broken icons
  - Download [nerdfix](https://github.com/loichyan/nerdfix) binary and unpack in home directory.
  - Run `nerdfix check <path/to/file>` to check broken icons in a file
  - Run `nerdfix fix <path/to/file>` to fix broken icons in a file
