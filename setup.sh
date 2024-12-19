#! /bin/bash

DOTFILES_DIR=~/dotfiles
CURRENT_DIR=$(pwd)

TARGET_DIR=~/.config/
IGNORED_FILES=("README.md" "setup.sh" ".git" "." "..")

is_ignored() {
  local file=$1
  for ignored in "${IGNORED_FILES[@]}"; do
    if [[ "$file" == "$ignored" ]]; then
      return 0
    fi
  done
  return 1
}

# check if DOTFILES_DIR exists
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Dotfiles directory: '$DOTFILES_DIR' doesn't exist"
  echo "Creating dotfiles dir"
  cp -r "$CURRENT_DIR" "$DOTFILES_DIR"
fi

# Copy all files to TARGET_DIR
for file in "$DOTFILES_DIR"/*; do
  filename=$(basename "$file")

  # Skip ignore files
  if is_ignored "$filename"; then
    echo "Skipping ignored file: '$filename'"
    continue
  fi

  # Create symlinks
  target="$TARGET_DIR/$filename"
  if [ -e "$target" ]; then
    echo "Skipping '$target' (already exists)"
  else
    ln -sf "$file" "$target"
    echo "Created symlink: '$target' -> '$file'"
  fi
done
