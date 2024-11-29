Literally just my `init.lua` for nvim configuration. I'm just a nice guy and like sharing yk...

## Prerequisites

### Linux

#### Ubuntu/Debian

```bash
sudo apt update
sudo apt install git curl unzip nodejs npm python3 python3-pip ripgrep fzf
```

#### Fedora

```bash
sudo dnf install git curl unzip nodejs npm python3 python3-pip ripgrep fzf
```

#### Arch

```bash
sudo pacman -S git curl unzip nodejs npm python3 python-pip ripgrep fzf
```

#### CentOS/RHEL

```bash
sudo yum install git curl unzip nodejs npm python3 python3-pip ripgrep fzf
```

### macOS

(Assuming [brew](https://brew.sh/) is installed)

```bash
brew install git curl unzip node python ripgrep fzf
```

## Neovim Installation

### macOS

```bash
brew install nvim
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

#### CentOS/RHEL

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
