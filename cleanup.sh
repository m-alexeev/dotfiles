#! /bin/bash
# Keep in sync with setup.sh: DOTFILES_DIR, TARGET_DIR, IGNORED_FILES

DOTFILES_DIR=~/dotfiles
TARGET_DIR=~/.config/
BKP_DIR="${DOTFILES_DIR%/}/bkp-$(date +%Y%m%d-%H%M%S)"
IGNORED_FILES=("README.md" "setup.sh" "cleanup.sh" ".git" "." "..")

is_ignored() {
  local f=$1
  for x in "${IGNORED_FILES[@]}"; do
    if [[ "$f" == "$x" ]]; then
      return 0
    fi
  done
  return 1
}

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Error: dotfiles directory '$DOTFILES_DIR' does not exist." >&2
  exit 1
fi

mkdir -p "$BKP_DIR" || exit 1
echo "Backup directory: $BKP_DIR"
conf_parent=$(cd "${TARGET_DIR%/}" && pwd)

shopt -s nullglob
for src in "$DOTFILES_DIR"/*; do
  name=$(basename "$src")
  is_ignored "$name" && continue

  target="${TARGET_DIR%/}/$name"
  if [[ ! -e "$target" && ! -L "$target" ]]; then
    echo "Skip (not present): $target"
    continue
  fi

  out="$BKP_DIR/${name}.tar.gz"
  # -L: follow symlinks so the archive contains real files, not just links
  tar -czLf "$out" -C "$conf_parent" "$name"
  rm -rf "$target"
  echo "Backed up to $out and removed: $target"
done
