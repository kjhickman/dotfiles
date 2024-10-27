# Nix Configuration

### Steps required for fresh MacOS install

#### Clone repository
```
git clone https://github.com/kjhickman/dotfiles.git nix
```

#### Install nix
https://github.com/DeterminateSystems/nix-installer

#### Install Rosetta
```
softwareupdate --install-rosetta
```

#### Install XCode
```
xcode-select --install
```

#### First Rebuild
```
nix run nix-darwin -- switch --flake ~/nix#macos
```
