Literally just my `init.lua` for nvim configuration in case I wanted to use it on another machine.
## Prerequisites

### Linux (Debian/Ubuntu)
```bash
sudo apt update
sudo apt install git curl unzip nodejs npm python3 python3-pip ripgrep
```

### Linux (Fedora)
```bash
sudo dnf install git curl unzip nodejs npm python3 python3-pip ripgrep
```

### Linux (Arch)
```bash
sudo pacman -S git curl unzip nodejs npm python3 python-pip ripgrep
```

### Linux (CentOS)
```bash
sudo yum install git curl unzip nodejs npm python3 python3-pip ripgrep
```

### macOS
(Assuming brew is installed)
```bash
brew install git curl unzip node python ripgrep
```

## Neovim Installation

### macOS 
```bash
brew install neovim
```

### Linux
#### Ubuntu/Debian
```bash
sudo apt install neovim
```
#### Fedora
```bash
sudo dnf install neovim
```
#### Arch
```bash
sudo pacman -S neovim
```
#### CentOS
```bash
sudo yum install epel-release
sudo yum install neovim
```

## Plugin Dependencies
```bash
npm install -g neovim
pip3 install pynvim
```

## Configuration
Clone the configuration:
```bash
git clone https://github.com/manitofigh/nvim.git ~/.config/nvim
```

## Final Steps

1. Open Neovim: `nvim`
2. Wait for plugins to install
3. Restart Neovim

## Note for Windows Users

I'd personally give up and use VSCode on Windows, but in case a future friend decided to start with my conf on their win machine:
</br>
Windows setup may differ and some plugins might not work as expected. You are probably better off using cygwin and some package manager for windows like scoop or chocolatey.
