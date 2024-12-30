#!/bin/bash

# Define source and target directories
BINARIES_DIR="$PWD/Binaries"
TARGET_DIR="$HOME/.local/bin"

# Ensure ~/.local/bin exists
mkdir -p "$TARGET_DIR"

# Check if the Binaries folder exists
if [[ ! -d "$BINARIES_DIR" ]]; then
    echo "❌ The 'Binaries' folder was not found in $PWD."
    exit 1
fi

# Find AppImages in the Binaries folder
APPIMAGES=($(find "$BINARIES_DIR" -maxdepth 1 -type f -name "*.AppImage"))

# Check if AppImages are found
if [[ ${#APPIMAGES[@]} -eq 0 ]]; then
    echo "❌ No AppImage files found in $BINARIES_DIR."
    exit 1
fi

# List all found AppImages
echo "📝 Found the following AppImage files:"
for i in "${!APPIMAGES[@]}"; do
    echo "$((i+1)). $(basename "${APPIMAGES[$i]}")"
done

# Ask user to select an AppImage
read -p "🔄 Enter the number of the AppImage to install: " SELECTION

# Validate selection
if [[ ! "$SELECTION" =~ ^[0-9]+$ ]] || (( SELECTION < 1 || SELECTION > ${#APPIMAGES[@]} )); then
    echo "❌ Invalid selection. Please enter a number between 1 and ${#APPIMAGES[@]}."
    exit 1
fi

# Get selected AppImage
SELECTED_APPIMAGE="${APPIMAGES[$((SELECTION-1))]}"

# Copy the selected AppImage to ~/.local/bin and rename it to dku
cp "$SELECTED_APPIMAGE" "$TARGET_DIR/dku"
mv "$TARGET_DIR/$SELECTED_APPIMAGE" "$TARGET_DIR/dku"


# Make the copied AppImage executable
chmod +x "$TARGET_DIR/dku"

# Verify installation
if [[ -x "$TARGET_DIR/dku" ]]; then
    echo "✅ The selected AppImage has been copied, renamed to 'dku', and moved to $TARGET_DIR."
else
    echo "❌ Failed to install the AppImage. Please check permissions."
    exit 1
fi

# Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "🔄 Adding ~/.local/bin to your PATH..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
fi

# Verify the command works
if command -v dku &> /dev/null; then
    echo "🚀 'dku' is now available as a command. Run 'dku --help' to verify."
else
    echo "❌ Something went wrong. 'dku' command is not recognized."
fi

