# minimal.nvim

A minimal configuration for NeoVim users.

## Issue(s)

With the current configurations present on the internet, I was not able to manage my configuration in the cleanest way possible.
I felt that LazyVim or Kickstart were opinionated. Obviously one could argue that one always has the freedom in order to change
the configuration/bindings according to their own likings. I wanted to have somethings from my older Vim days as well as some
from the NeoVim side. In certain cases, the older configurations having Vim-script commands were also required and those were
pasted in the configuration inside the `vim.cmd` portion.
This was something that was not sitting well with me. Also, I had gotten disinterested in all the extra things that plugins do.
For example, I got sick and tired of the `catppuccin` theme, the `snacks` and `mini` plugins and the like. I wanted my editor
to be like that of Linus/DMR/René Rebe - just pure white/shades of grey to identify various things on the UI and dark black
background colour.

So, in order to achieve the aim of _editor should get out of my way_ of programming, I listed down my requirements.

## Requirements

The following are some of the requirements that I thought would allow my editor to be inline with my current minimalistic outlook:
 - Monotone colour scheme : The editor should highlight everything in shades of grey with dark black background.
 - Nerd tree like file explorer: This is from my Vim Editing days, I always need to have a project/file explorer.
 - Code outline: For the currently opened file, I would like to have the outline of the code present.
 - Ruler like status bar with only the git branch
 - Show function/class preview along with references(usage references)
 - Fuzzy file searching, opening as well as switching of buffers.
 - Unicode symbol insertion: This is a must have because looking at texts without symbols is no fun, symbols provide fun to read.
 - Documentation viewing
 - LSP support: This is coming from Vim as well as early NeoVim days. Autocompletion and suggestions are a must.
 - Quick grep using `ripgrep`
 - Breadcrumbs at the top of the window: This feature is inspired by VS Code and I kind of like it.
 - Show errors as a virtual text as well as on placing the cursor on specified line.
 - Easily show diagnostics and allow jumping to specific lines.
 - Allow collapsing and expanding of sections.

With these requirements in mind, this configuration has been made. In order to support the current clean configuration process, the one
and only requirement is to have NeoVim 0.12.x (preferably 0.12.5+). By default, `Pyright` and `lua-lsp` is installed. If anyone
needs more LSP servers, they can install the same using `Mason` from with Neovim.

## Installation

In order to install this configuration, make sure that your NeoVim distribution is having the right version. This could be found using the
following command:
``` bash
nvim --version
```
**Output**:
```bash
NVIM v0.12.5
Build type: Release
LuaJIT 2.1.1774638290
Run "nvim -V1 -v" for more info
```

Once the version is confirmed, please use the following commands in order to get this configuration setup properly.

**Steps**:
 - Clean the local cache using the command:
 ```bash
 rm -rf ~/.cache/nvim
 ```
 One can also rename it using command:
 ```bash
 mv ~/.cache/nvim ~/.cache/nvim-bkup
 ```
 - Clean the local share using the command:
 ```bash
 rm -rf ~/.local/share/nvim```
 or rename it using command:
 ```bash
 mv ~/.local/share/nvim ~/.local/share/nvim-bkup
 ```
 - Clean the local state using the command:
 ```bash
 rm -rf ~/.local/state/nvim
 ```
 or rename it using command:
 ```bash
 mv ~/.local/state/nvim ~/.local/state/nvim-bkup
 ```
 - Delete the existing configuration using:
 ```bash
 rm -rf ~/.config/nvim
 ```
 or rename it using command:
 ```bash
 mv ~/.config/nvim ~/.config/nvim-bkup
 ```
 - Clone this repository and provide the directory name:
 ```bash
 git clone https://github.com/artemisfowl/minimal.nvim.git ~/.config/nvim
 ```
 - Once the cloning is over, please start NeoVim. Editor will be asking for a confirmation for cloning the necessary plugins, please press (y) and wait for the initial configuration to be over.

