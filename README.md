Literally just my `init.lua` for nvim configuration in case I wanted to use it on another machine.
## Prerequisites

### Linux (Debian/Ubuntu)
sudo apt update
sudo apt install git curl unzip nodejs npm python3 python3-pip ripgrep

### Linux (Fedora)
sudo dnf install git curl unzip nodejs npm python3 python3-pip ripgrep

### macOS
brew install git curl unzip node python ripgrep

## Neovim Installation

### macOS (Alternative)
brew install neovim

### Linux
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
sudo mv nvim-linux64 /opt/
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/<.bashrc|.zshrc>
source ~/<.bashrc|.zshrc>

## Plugin Dependencies

npm install -g neovim
pip3 install pynvim

## Configuration

Clone the configuration:
git clone https://github.com/your-repo/neovim-config.git ~/.config/nvim

## Final Steps

1. Open Neovim: nvim
2. Wait for plugins to install
3. Restart Neovim

## Note for Windows Users

I know this is not going to be for myself (I'd just give up and use VSCode on windows), but in case a future friend decided to start with my configuration on their win machine:
</br>
Windows setup may differ and some plugins might not work as expected. You are probably better off using cygwin and some package manager for windows like scoop or chocolatey.
