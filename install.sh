#!/usr/bin/env bash
#
# CTOS Plasma 6 Splash Screen — installer
# Installs the CTOS look-and-feel package for the current user.
#
set -euo pipefail

DEST_DIR="${HOME}/.local/share/plasma/look-and-feel"
PKG_NAME="CTOS"

# Pretty colors
if [ -t 1 ]; then
    BOLD='\033[1m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'
else
    BOLD=''; GREEN=''; YELLOW=''; RED=''; NC=''
fi

info()  { printf "${GREEN}✔${NC} %s\n" "$1"; }
warn()  { printf "${YELLOW}!${NC} %s\n" "$1"; }
die()   { printf "${RED}✘${NC} %s\n" "$1" >&2; exit 1; }

echo -e "${BOLD}CTOS Splash Screen — installer${NC}"
echo ""

# --- Sanity checks ----------------------------------------------------------
command -v plasmashell >/dev/null 2>&1 || die "plasmashell not found. Are you running KDE Plasma?"
mkdir -p "$DEST_DIR" || die "Could not create $DEST_DIR"

# Plasma 6 check (warn, don't fail — users may know what they're doing)
PS_VER="$(plasmashell --version 2>/dev/null | awk '{print $2}')"
if [ -n "$PS_VER" ] && [[ "$PS_VER" != 6.* ]]; then
    warn "Detected Plasma $PS_VER — this theme targets Plasma 6. It may not work correctly."
fi

# --- Fetch source -----------------------------------------------------------
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# If run from inside the repo, install from local src/.
if [ -f "$(pwd)/src/$PKG_NAME/metadata.json" ]; then
    SRC="$(pwd)/src/$PKG_NAME"
    info "Installing from local repository: $SRC"
else
    info "Downloading CTOS from GitHub..."
    URL="https://github.com/debarch777/ctos-plasma-splash/archive/refs/heads/main.tar.gz"
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$URL" -o "$TMP/ctos.tar.gz"
    elif command -v wget >/dev/null 2>&1; then
        wget -qO "$TMP/ctos.tar.gz" "$URL"
    else
        die "Need curl or wget to download."
    fi
    tar -xzf "$TMP/ctos.tar.gz" -C "$TMP"
    SRC="$TMP/ctos-plasma-splash-main/src/$PKG_NAME"
    [ -f "$SRC/metadata.json" ] || die "Downloaded package is missing files."
fi

# --- Install ----------------------------------------------------------------
if [ -d "$DEST_DIR/$PKG_NAME" ]; then
    warn "Existing $PKG_NAME found — replacing it."
    rm -rf "$DEST_DIR/$PKG_NAME"
fi
cp -r "$SRC" "$DEST_DIR/$PKG_NAME"
info "Installed to $DEST_DIR/$PKG_NAME"

# --- Activate prompt --------------------------------------------------------
echo ""
echo -e "${BOLD}Almost done.${NC} To activate:"
echo "  1. Open ${BOLD}System Settings → Appearance → Splash Screen${NC}"
echo -  "  2. If CTOS doesn't show yet, restart Plasma:"
echo "       kquitapp6 plasmashell && kstart plasmashell"
echo "     (or just log out and back in)"
echo "  3. Select ${BOLD}CTOS${NC} → ${BOLD}Apply${NC}"
echo "  4. Press ${BOLD}Test${NC} to preview without rebooting"
echo ""
info "Done. Enjoy the clean boot."
