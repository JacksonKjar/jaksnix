#!/usr/bin/env bash
set -euo pipefail

# jaksnix bootstrap — from zero to home-manager on a fresh Linux server
# Usage: curl -fsSL https://raw.githubusercontent.com/JacksonKjar/jaksnix/main/bootstrap.sh | bash
#   or:  ./bootstrap.sh [config-name]
#
# config-name: "server" (default, x86_64) or "server-aarch64" (ARM/Graviton)

CONFIG="${1:-server}"
REPO="github:JacksonKjar/jaksnix"

info()  { printf '\033[1;34m→\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m✓\033[0m %s\n' "$*"; }
err()   { printf '\033[1;31m✗\033[0m %s\n' "$*" >&2; exit 1; }

# --- 1. Install Nix (Determinate Systems installer) ---
if command -v nix &>/dev/null; then
  ok "Nix already installed ($(nix --version))"
else
  info "Installing Nix via Determinate Systems installer..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
    | sh -s -- install --no-confirm
  # Source nix daemon env for this shell
  if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  elif [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
  ok "Nix installed ($(nix --version))"
fi

# --- 2. Run home-manager switch ---
info "Activating home-manager configuration '${CONFIG}' from ${REPO}..."

# Use home-manager from the flake to switch
nix run "${REPO}#homeConfigurations.${CONFIG}.activationPackage" --no-write-lock-file --impure

ok "Done! Open a new shell or run: exec \$SHELL -l"
echo ""
info "To update later: nix run ${REPO}#homeConfigurations.${CONFIG}.activationPackage --impure"
info "Or clone and use: home-manager switch --flake ~/jaksnix#${CONFIG} --impure"
