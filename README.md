# 🛠️ My Neovim Configuration

If you think Vim is hard, wait until you see what I've done here. But hey, at least it looks cool!

---

## 🚀 Quick Start Options

### **Option 1: Try This Config Without Overwriting Your Existing One**

If you already have a Neovim configuration and want to keep it intact while trying this one, follow these steps:

1. **Clone the Repository**:
   ```
   git clone https://github.com/lmilojevicc/nvim-config ~/.config/nvim-alt
   ```

2. **Launch Neovim with the New Config**:
   Use the `NVIM_APPNAME` environment variable to specify the alternate config directory:
   ```
   NVIM_APPNAME=nvim-alt nvim
   ```

3. **Optional: Create an Alias**:
   To make launching this configuration easier, add an alias to your shell configuration file (e.g., `.bashrc`, `.zshrc`):
   ```
   alias nvim-alt='NVIM_APPNAME=nvim-alt nvim'
   ```

4. **Enjoy!**  
   You can now switch between your original config and this one effortlessly.

---

### **Option 2: Use This Config as Your Default**

If you don’t have an existing Neovim configuration or don’t mind replacing it, follow these steps:

1. **Backup Your Existing Config (Optional)**:
   If you want to save your current setup, back it up first:
   ```
   mv ~/.config/nvim ~/.config/nvim-backup
   ```

2. **Clone the Repository**:
   ```
   git clone https://github.com/lmilojevicc/nvim-config ~/.config/nvim
   ```

3. **Launch Neovim**:
   Simply run:
   ```
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
- `git`
- `ripgrep` 
- `fzf` 
- `node`

---

## 📂 Directory Structure


```
.
├── init.lua                  # Main entry point for Neovim
├── lazy-lock.json            # Plugin lockfile for Lazy.nvim
└── lua/
    └── luka/
        ├── core/             # Core configurations
        │   ├── init.lua      # Core initialization
        │   ├── mappings.lua  # Keymaps
        │   └── options.lua   # Neovim options
        ├── lazy.lua          # Lazy.nvim plugin manager config
        └── plugins/          # Individual plugin configurations
```

---

## 💡 Tips & Tricks

- Customize this setup by editing files in the `lua/` directory.
- To add or remove plugins, add or remove files from lua/luka/plugins.

