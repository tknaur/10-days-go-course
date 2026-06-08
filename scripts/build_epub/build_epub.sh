#!/bin/bash

##############################################################################
# Build EPUB from Markdown
# Converts Go Course markdown to EPUB with syntax highlighting
##############################################################################

set -euo pipefail

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
VENV_DIR="$SCRIPT_DIR/.venv"
OUTPUT_DIR="$SCRIPT_DIR/output"
THEMES_DIR="$SCRIPT_DIR/themes"
METADATA_FILE="$SCRIPT_DIR/metadata.yaml"
DEFAULT_THEME="$THEMES_DIR/default.css"
DEFAULT_INPUT="$REPO_ROOT/Go_Course_10_Days.md"
DEFAULT_OUTPUT="$OUTPUT_DIR/Go_Course_10_Days.epub"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo $SCRIPT_DIR
echo $REPO_ROOT
echo $DEFAULT_INPUT
##############################################################################
# Functions
##############################################################################

print_usage() {
  cat << EOF
Usage: $0 [OPTIONS]

Build EPUB from Markdown with syntax highlighting

OPTIONS:
  -i, --input FILE        Input markdown file (default: $DEFAULT_INPUT)
  -o, --output FILE       Output EPUB file (default: $DEFAULT_OUTPUT)
  -t, --theme THEME       Theme CSS file (default: $DEFAULT_THEME)
  -m, --metadata FILE     Metadata file (default: $METADATA_FILE)
  -h, --help              Show this help message

EXAMPLES:
  # Build with defaults
  $0

  # Custom input and output
  $0 -i custom.md -o output.epub

  # Use custom theme
  $0 -t themes/dark.css

EOF
}

log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

check_venv() {
  if [[ ! -d "$VENV_DIR" ]]; then
    log_error "Virtual environment not found at $VENV_DIR"
    log_info "Please run: python3 -m venv $VENV_DIR"
    log_info "Then run: source $VENV_DIR/bin/activate && pip install -r requirements.txt"
    exit 1
  fi
}

check_dependencies() {
  log_info "Checking dependencies..."
  
  if ! command -v pandoc &> /dev/null; then
    log_warning "Pandoc not found in PATH, will try to use pypandoc..."
  fi
  
  if [[ ! -f "$METADATA_FILE" ]]; then
    log_warning "Metadata file not found at $METADATA_FILE, using defaults"
  fi
}

##############################################################################
# Main Script
##############################################################################

# Parse arguments
INPUT="$DEFAULT_INPUT"
OUTPUT="$DEFAULT_OUTPUT"
THEME="$DEFAULT_THEME"
METADATA="$METADATA_FILE"

while [[ $# -gt 0 ]]; do
  case $1 in
    -i|--input)
      INPUT="$2"
      shift 2
      ;;
    -o|--output)
      OUTPUT="$2"
      shift 2
      ;;
    -t|--theme)
      THEME="$2"
      shift 2
      ;;
    -m|--metadata)
      METADATA="$2"
      shift 2
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      log_error "Unknown option: $1"
      print_usage
      exit 1
      ;;
  esac
done

# Validation
if [[ ! -f "$INPUT" ]]; then
  log_error "Input file not found: $INPUT"
  exit 1
fi

if [[ ! -f "$THEME" ]]; then
  log_error "Theme file not found: $THEME"
  exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Activate venv
check_venv
source "$VENV_DIR/bin/activate"

# Check dependencies
check_dependencies

log_info "Starting EPUB conversion..."
log_info "Input:  $INPUT"
log_info "Output: $OUTPUT"
log_info "Theme:  $THEME"

# Build pandoc command
PANDOC_CMD="pandoc"
PANDOC_ARGS=(
  "$INPUT"
  "-o" "$OUTPUT"
  "-t" "epub"
  "--css=$THEME"
  "--syntax-highlighting=pygments"
  "-s"  # Standalone
  "--toc"  # Table of contents
  "--toc-depth=2"
)

# Add metadata if file exists
if [[ -f "$METADATA" ]]; then
  PANDOC_ARGS+=("--metadata-file=$METADATA")
fi

# Run pandoc
log_info "Running: $PANDOC_CMD ${PANDOC_ARGS[*]}"

if $PANDOC_CMD "${PANDOC_ARGS[@]}"; then
  log_success "EPUB generated successfully: $OUTPUT"
  
  # Show file info
  if [[ -f "$OUTPUT" ]]; then
    SIZE=$(du -h "$OUTPUT" | cut -f1)
    log_info "File size: $SIZE"
  fi
else
  log_error "Pandoc conversion failed!"
  exit 1
fi

log_success "Done!"
