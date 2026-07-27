#!/usr/bin/env bash
set -euo pipefail

# jaksnix bootstrap — from zero to home-manager on a fresh Linux server
# Usage: curl -fsSL https://raw.githubusercontent.com/JacksonKjar/jaksnix/master/bootstrap.sh | bash
#   or:  ./bootstrap.sh [config-name]
#
# config-name: "server" (default, auto-detects arch) or "server-aarch64" / "server-x86_64"

CONFIG="${1:-server}"
REPO="github:JacksonKjar/jaksnix"

info()  { printf '\033[1;34m→\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m✓\033[0m %s\n' "$*"; }
err()   { printf '\033[1;31m✗\033[0m %s\n' "$*" >&2; exit 1; }

# --- 1. Install Nix (single-user, no daemon) ---
if command -v nix &>/dev/null; then
  ok "Nix already installed ($(nix --version))"
else
  info "Installing Nix (single-user, no daemon)..."

  # Create /nix owned by current user (only step needing sudo)
  if [ ! -d /nix ]; then
    sudo mkdir -m 0755 /nix
    sudo chown "$(id -u):$(id -g)" /nix
  fi

  # Vanilla nix installer, single-user mode
  sh <(curl -fsSL https://nixos.org/nix/install) --no-daemon

  # Source nix env for this shell
  if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
  ok "Nix installed ($(nix --version))"
fi

# --- 2. Run home-manager switch ---
info "Activating home-manager configuration '${CONFIG}' from ${REPO}..."

nix run "${REPO}#homeConfigurations.${CONFIG}.activationPackage" \
  --no-write-lock-file --impure \
  --extra-experimental-features "nix-command flakes"

ok "Done! Open a new shell or run: exec \$SHELL -l"
echo ""
info "To update later: jaksnix-update"
info "Or: nix run ${REPO}#homeConfigurations.${CONFIG}.activationPackage --no-write-lock-file --impure"
