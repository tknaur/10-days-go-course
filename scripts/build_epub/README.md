# EPUB Generation Scripts

This directory contains scripts and tools for converting the Go Course markdown to professional EPUB format with syntax-highlighted code blocks.

## Overview

The EPUB generation system uses:
- **Pandoc** - Industry-standard markdown to EPUB converter
- **Pygments** - Syntax highlighting for multiple programming languages
- **Custom CSS Theme** - Professional styling with beautiful code highlighting
- **Python venv** - Isolated, reproducible environment

## Quick Start

### Prerequisites

- Python 3.8 or later
- Internet connection (to download Pandoc via pypandoc)

### Setup (One-time)

```bash
# From this directory
cd scripts/

# Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Download Pandoc
python3 -c "import pypandoc; pypandoc.download_pandoc()"

# Deactivate when done
deactivate
```

### Generate EPUB

```bash
# From the repo root
./scripts/build_epub.sh

# OR from the scripts directory
bash build_epub.sh

# With custom options
./scripts/build_epub.sh -i path/to/input.md -o path/to/output.epub -t themes/default.css
```

## File Structure

```
scripts/
├── .venv/                  # Python virtual environment (auto-created)
├── .gitignore              # Ignore venv and cache files
├── build_epub.sh           # Main conversion script
├── requirements.txt        # Python dependencies
├── metadata.yaml           # EPUB metadata (title, author, etc.)
├── README.md               # This file
├── themes/
│   └── default.css         # Custom CSS with syntax highlighting
└── Makefile                # Optional convenience targets
```

## Script Usage

### `build_epub.sh`

Main script for EPUB generation.

**Usage:**
```bash
./build_epub.sh [OPTIONS]
```

**Options:**
```
-i, --input FILE        Input markdown file (default: ../Go_Course_10_Days.md)
-o, --output FILE       Output EPUB file (default: ../output/Go_Course_10_Days.epub)
-t, --theme FILE        Theme CSS file (default: themes/default.css)
-m, --metadata FILE     Metadata file (default: metadata.yaml)
-h, --help              Show help message
```

**Examples:**
```bash
# Generate with defaults
./build_epub.sh

# Custom input/output
./build_epub.sh -i my_course.md -o my_output.epub

# Use different theme
./build_epub.sh -t themes/dark.css

# All options
./build_epub.sh \
  -i ../Go_Course_10_Days.md \
  -o ../output/go_course.epub \
  -t themes/default.css \
  -m metadata.yaml
```

## Customization

### Metadata

Edit `metadata.yaml` to customize EPUB metadata:
```yaml
---
title: "Your Custom Title"
author: "Your Name"
date: "2024"
---
```

### CSS Themes

Create new themes in the `themes/` directory. Example structure:

```css
/* Custom theme */
:root {
  --primary-color: #1a73e8;
  --code-bg: #f5f5f5;
  --text-color: #202124;
}

code {
  background-color: var(--code-bg);
  color: #d73a49;
}

pre {
  border-left: 4px solid var(--primary-color);
  background-color: var(--code-bg);
}
```

Then use it:
```bash
./build_epub.sh -t themes/mycustom.css
```

## Features

### Syntax Highlighting

The generated EPUB includes beautiful syntax highlighting for multiple languages:
- **Go** - Primary language with enhanced highlighting
- **Bash** - Shell scripts
- **Python** - Python code
- **JSON** - JSON data
- **SQL** - SQL queries
- **HTML/JavaScript** - Web technologies
- **And more** - Pygments supports 500+ languages

### Professional Styling

- Clean, readable typography
- Well-organized headings with color hierarchy
- Responsive code blocks with left border accent
- Syntax-highlighted inline code
- Table styling with alternating row colors
- Blockquote styling
- Dark mode support for e-readers

### EPUB Features

- Automatic table of contents (generated from headings)
- Embedded CSS for consistent appearance
- Proper semantic markup
- Compatible with all major e-readers
  - Amazon Kindle
  - Apple Books
  - Google Play Books
  - Kobo
  - Other EPUB-compliant readers

## Requirements

### System Requirements
- Python 3.8+
- ~100MB disk space for venv and Pandoc

### Python Dependencies
See `requirements.txt` for the complete list:
- pypandoc - Python wrapper for Pandoc
- pygments - Syntax highlighting
- panflute - Pandoc filter library
- pyyaml - YAML parsing
- lxml - XML processing
- natsort - Natural sorting
- click - CLI utilities

### External Tools
- Pandoc 3.0+ (auto-downloaded via pypandoc)

## Troubleshooting

### "Virtual environment not found"
```bash
cd scripts/
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python3 -c "import pypandoc; pypandoc.download_pandoc()"
deactivate
```

### "Pandoc not found"
```bash
source scripts/.venv/bin/activate
python3 -c "import pypandoc; pypandoc.download_pandoc()"
```

### "Permission denied" on script
```bash
chmod +x scripts/build_epub.sh
```

### Large file size or conversion takes too long
- This is normal for a 1500+ line course document
- EPUB size is ~36KB with full syntax highlighting
- Conversion typically takes 5-10 seconds

### Syntax highlighting not appearing
- Ensure you're using `--syntax-highlighting=pygments`
- Verify the theme CSS file is valid
- Check that code blocks use proper markdown syntax:
  ```go
  // Your code here
  ```

## Advanced Usage

### Creating a Dark Theme

Create `themes/dark.css` with dark mode colors:
```css
:root {
  --primary-color: #4d9dff;
  --code-bg: #1e1e1e;
  --text-color: #e0e0e0;
}

/* ... rest of theme ... */
```

### Batch Processing Multiple Files

```bash
#!/bin/bash
for file in *.md; do
  name="${file%.md}"
  ./build_epub.sh -i "$file" -o "output/${name}.epub"
done
```

### Using with Version Control

```bash
# Add to git
git add scripts/
git add Go_Course_10_Days.md

# Ignore generated files
git add .gitignore
```

## Performance Notes

- **Conversion time**: ~5-10 seconds for the full course
- **Output size**: ~36KB (highly compressed)
- **Memory usage**: Minimal, typically <50MB
- **Pandoc features used**:
  - Syntax highlighting with Pygments
  - Standalone EPUB generation
  - Auto-generated table of contents
  - Custom CSS embedding

## Support

For issues or questions:
1. Check the Troubleshooting section above
2. Verify all dependencies are installed: `pip list`
3. Test with default settings: `./build_epub.sh`
4. Check Pandoc version: `pandoc --version`

## License

Same as the parent repository. The build scripts and themes are provided as utilities for course distribution.

## Resources

- [Pandoc Documentation](https://pandoc.org/)
- [Pygments Highlighting](https://pygments.org/)
- [EPUB Specification](https://www.w3.org/publishing/epub32/)
- [CSS for EPUB](https://www.w3.org/publishing/epub32/epub-contentdocs.html#sec-css)
