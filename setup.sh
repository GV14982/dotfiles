#!/bin/sh

# Install Nix
curl -L https://nixos.org/nix/install | sh

# Setup Github CLI
./scripts/gh.sh

# Setup programs managed by mise
./scripts/mise.sh

# Setup delta diff
./scripts/delta.sh
