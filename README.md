# 🛠️ My Neovim Configuration

Meet the ultimate paradox where productivity and procrastination intertwine in a never-ending cycle of Neovim tweaks.

---

## 🚀 Quick Start Options

### **Option 1: Try This Config Without Overwriting Your Existing One**

If you already have a Neovim configuration and want to keep it intact while trying this one, follow these steps:

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/lmilojevicc/nvim-config ~/.config/nvim-alt
   ```

2. **Launch Neovim with the New Config**:
   Use the `NVIM_APPNAME` environment variable to specify the alternate config directory:

   ```bash
   NVIM_APPNAME=nvim-alt nvim
   ```

3. **Optional: Create an Alias**:
   To make launching this configuration easier, add an alias to your shell configuration file (e.g., `.bashrc`, `.zshrc`):

   ```bash
   alias nvim-alt='NVIM_APPNAME=nvim-alt nvim'
   ```

4. **Enjoy!**  
   You can now switch between your original config and this one effortlessly.

---

### **Option 2: Use This Config as Your Default**

If you don’t have an existing Neovim configuration or don’t mind replacing it, follow these steps:

1. **Backup Your Existing Config (Optional)**:
   If you want to save your current setup, back it up first:

   ```bash
   mv ~/.config/nvim ~/.config/nvim-backup
   ```

2. **Clone the Repository**:

   ```bash
   git clone https://github.com/lmilojevicc/nvim-config ~/.config/nvim
   ```

3. **Launch Neovim**:
   Simply run:

   ```bash
   nvim
   ```

4. **Install Plugins**:
   Install the plugins by running the following command:

   ```
   :Lazy sync
   ```

---

## 🛠️ Requirements

Make sure you have the following installed on your system before using this configuration:

- [Nerd font](https://www.nerdfonts.com/) of your choice
- [Neovim](https://neovim.io/)
- External tools:
  - `fd`
  - `fzf`
  - `git`
  - `node`
  - `ripgrep`
  - `lazygit`

---

## 📂 Directory Structure

```
.
├── init.lua                  # Main entry point for Neovim
├── ftplugin/                 # Filetype-specific settings (loaded automatically when opening matching files)
├── lazy-lock.json            # Dependency lock file (automatically managed by Lazy.nvim)
└── lua/
    ├── config/               # Core configuration modules
    │   ├── init.lua          # Initializes and loads all core configurations
    │   ├── lazy.lua          # Lazy plugin manager setup and configuration
    │   ├── keymaps.lua       # Global keybindings and keyboard shortcuts
    │   ├── autocmds.lua      # Autocommands for automatic actions on events
    │   └── options.lua       # Neovim built-in options and settings
    ├── disabled/             # Archived configurations (temporarily disabled plugins)
    └── plugins/              # Plugin-specific configurations
        └── ...
```

---

## 💡 Tips & Tricks

- `<Space>` is used as the leader key by default
- Use `<leader>wk` to search through key bindings
