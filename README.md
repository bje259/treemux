# Treemux for Tmux

Nothing has been this close to an IDE!

`Treemux` opens a sidebar with Neovim's [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua) file explorer,
with additional cool features like:

- Automatic updates on Nvim-Tree as you change directory in shell.
- Nvim-Tree to shell interaction possible with [tmuxsend.vim](https://github.com/kiyoon/tmuxsend.vim).
  - You can copy absolute path from Nvim-Tree and paste into the shell.
  - Change directory, execute programs, open with vim and anything you can imagine!
- Open files from Nvim-Tree to Neovim seamlessly, using [nvim-tree-remote.nvim](https://github.com/kiyoon/nvim-tree-remote.nvim).
  - Just open the files (double click) and it will show up in another Neovim!

<img src="https://user-images.githubusercontent.com/12980409/209864681-a11b3390-d41d-4efc-bb12-a55752e62793.gif" width="100%"/>

Of course you also get:

- All features from Nvim-Tree:
	- **mouse click**
	- **automatic refresh**
	- **file icons**
- All features from tmux-sidebar:
	- **smart sizing**<br/>
	  Sidebar remembers its size, so the next time you open it, it will have the
	  **exact same** width. This is a per-directory property, so you can have just
	  the right size for multiple dirs.
	- **toggling**<br/>
	  The same key binding opens and closes the sidebar.
	- **uninterrupted workflow**<br/>
	  The main `prefix + Tab` key binding opens a sidebar but **does not** move
	  cursor to it.
	- **pane layout stays the same**<br/>
	  No matter which pane layout you prefer, sidebar tries hard not to mess your
	  pane splits. Open, then close the sidebar and everything should look the same.

Furthermore, it will detect git directory and open that as root, while still opening current directory.

Tested and working on Linux, MacOS and Windows WSL2.

### Key bindings

- `prefix + Tab` - toggle sidebar with a directory tree
- `prefix + Backspace` - toggle sidebar and move cursor to it (focus it)
- `prefix + C-t` - enter instant IDE mode
- `prefix + C-e` - enter instant IDE mode and focus on the Nvim-Tree

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add plugin to the list of TPM plugins in `.tmux.conf`:
	
	set -g @treemux-tree-nvim-init-file '~/.tmux/plugins/treemux/configs/treemux_init.vim'
    set -g @plugin 'kiyoon/treemux'

- Tip: It is recommended to use a separate init file for this! By default (if you don't set `@treemux-tree-nvim-init-file`) it will load your neovim config but make sure you have Nvim-Tree setup correctly in this case.
  - You can copy the `treemux_init.vim` file and modify the settings there as you want.

Hit `prefix + I` to fetch the plugin and source it.

Install python support for Neovim.  
```bash
pip3 install --user pynvim
```

Make sure you have Neovim installed.  
You should now be able to use the plugin.

### Docs

- [customisation options](docs/options.md)

### License

[MIT](LICENSE.md)
