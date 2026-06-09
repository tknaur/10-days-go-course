# 10-Days Go Course

A comprehensive 10-day introduction to Go (Golang) with **automated EPUB generation** featuring professional syntax highlighting and optimized typography.

## 📚 Overview

This repository contains a complete introductory Go course delivered as markdown, with an automated build system to generate a professionally formatted EPUB file. The course covers Go fundamentals over 10 days with practical examples, clear explanations, and syntax-highlighted code blocks.

### ✨ Features

- **Comprehensive Go Course**: 10-day curriculum covering fundamentals to intermediate concepts
- **Automated EPUB Generation**: Single-command conversion from markdown to EPUB format
- **Syntax Highlighting**: Go-specific code highlighting with color-optimized themes
- **Professional Styling**: 
  - Go-language-optimized color scheme (blue #0173da, keyword pink, string green)
  - Responsive typography with 1.7 line-height for readability
  - Dark mode support
  - High-contrast table styling
  - Beautiful blockquotes and code blocks with gradients
- **Virtual Environment**: Self-contained Python environment with all dependencies
- **Metadata Support**: YAML-based EPUB metadata (title, author, date)
- **Syntax Highlighting**: Pygments-based highlighting with Go language support

## 📁 Directory Structure

```
10-days-go-course/
├── Go_Course_10_Days.md              # Main course content (markdown)
├── README.md                         # This file
├── LICENSE                           # License information
├── audio/                            # Audio resources (optional)
├── output/                           # Generated EPUB files (output)
├── scripts/
│   └── build_epub/
│       ├── build_epub.sh             # Main build script
│       ├── requirements.txt           # Python dependencies
│       ├── metadata.yaml              # EPUB metadata (title, author)
│       ├── .venv/                     # Python virtual environment
│       ├── themes/
│       │   └── default.css            # EPUB CSS theme (Go-optimized)
│       └── output/                    # Build output directory
└── .git/                             # Git repository
```

## 🚀 Getting Started

### Prerequisites

- **Pandoc** (for markdown to EPUB conversion)
- **Python 3.8+** (for the build environment)
- **bash** shell

### Installation

#### 1. Clone the Repository

```bash
git clone <repository-url>
cd 10-days-go-course
```

#### 2. Set Up the Virtual Environment

The build script automatically creates and activates a Python virtual environment with required dependencies.

```bash
cd scripts/build_epub
source .venv/bin/activate
pip install -r requirements.txt
```

Or use the automated setup in the build script (see usage below).

#### 3. Verify Pandoc Installation

```bash
pandoc --version
```

If not installed on Ubuntu/Debian:
```bash
sudo apt-get install pandoc
```

For other systems, see: https://pandoc.org/installing.html

## 📖 Usage

### Build EPUB (Basic)

```bash
./scripts/build_epub/build_epub.sh
```

This generates `scripts/build_epub/output/Go_Course_10_Days.epub`

### Build EPUB (Advanced Options)

```bash
./scripts/build_epub/build_epub.sh [OPTIONS]

Options:
  -i, --input <file>       Input markdown file (default: Go_Course_10_Days.md)
  -o, --output <file>      Output EPUB file (default: Go_Course_10_Days.epub)
  -t, --theme <file>       CSS theme file (default: themes/default.css)
  -m, --metadata <file>    YAML metadata file (default: metadata.yaml)
  -h, --help              Show this help message
```

### Examples

Generate with custom theme:
```bash
./scripts/build_epub/build_epub.sh -t my_theme.css
```

Specify custom output location:
```bash
./scripts/build_epub/build_epub.sh -o ~/ebooks/go-course.epub
```

## 🎨 Customization

### Modify the Theme

Edit `scripts/build_epub/themes/default.css` to customize:
- **Color palette**: Lines 5-20 (CSS variables)
- **Typography**: Lines 22-30 (fonts, sizes, line-height)
- **Headings**: Lines 33-72 (heading styles and colors)
- **Code syntax**: Lines 103-197 (Pygments token colors)
- **Tables**: Lines 221-255 (table styling and contrast)
- **Dark mode**: Lines 329-383 (@media prefers-color-scheme)

### Update EPUB Metadata

Edit `scripts/build_epub/metadata.yaml`:
```yaml
title: 10-Days Go Course
author: Your Name
date: 2024-01-01
language: en-US
```

Then rebuild the EPUB.

### Add Dependencies

If you need to add Python packages:
1. Edit `scripts/build_epub/requirements.txt`
2. Re-run the build script (it auto-installs requirements)

## 📦 Dependencies

### Python Packages

- **pypandoc** (1.17): Python wrapper for Pandoc
- **Pygments** (2.20.0): Syntax highlighting
- **panflute** (2.3.1): Pandoc filters for document manipulation
- **pandoc-include** (1.4.4): File inclusion support
- **PyYAML** (6.0.3): YAML metadata parsing
- **lxml** (6.1.1): XML/HTML processing
- **natsort** (8.4.0): Natural sorting
- **click** (8.4.1): Command-line interface utilities

### System Dependencies

- **Pandoc** (≥3.0): Document conversion engine
- **bash**: Shell script execution

## 🎯 Build System Details

### How It Works

1. **Markdown Processing**: Pandoc reads `Go_Course_10_Days.md`
2. **Syntax Highlighting**: Pygments highlights code blocks with Go-specific colors
3. **CSS Injection**: `default.css` is embedded in the EPUB for styling
4. **Metadata**: `metadata.yaml` provides title, author, date
5. **EPUB Generation**: Creates `Go_Course_10_Days.epub` (EPUB 3.0 format)

### Build Output

The generated EPUB:
- Validates against EPUB 3.0 specification
- Contains embedded CSS with all styling
- Includes syntax-highlighted code blocks
- Is compatible with major e-readers (Kindle, Apple Books, Kobo, etc.)
- File size: ~44KB (gzip-compressed)

## 📝 Course Structure

The course covers Go fundamentals across 10 days:

- **Day 1-2**: Go basics, syntax, setup
- **Day 3-4**: Data types, variables, operators
- **Day 5-6**: Control flow, functions, packages
- **Day 7-8**: Concurrency, goroutines, channels
- **Day 9-10**: Interfaces, error handling, testing

All content is in `Go_Course_10_Days.md`

## 🔍 Code Highlighting

The theme supports Go-specific syntax highlighting:

- **Keywords** (if, for, func): Pink (#d4145a)
- **Strings** ("hello"): Green (#078905)
- **Numbers** (42, 3.14): Orange
- **Comments** (// comment): Gray
- **Built-ins** (fmt.Println): Go blue (#0173da)

Add custom Go code blocks with:
```markdown
\`\`\`go
func main() {
    fmt.Println("Hello, Go!")
}
\`\`\`
```

## 📊 EPUB Formatting Features

- ✅ Professional typography (1.7 line-height, system fonts)
- ✅ Syntax-highlighted code blocks with gradients
- ✅ High-contrast tables with hover effects
- ✅ Styled blockquotes with left border
- ✅ Responsive images
- ✅ Dark mode support
- ✅ Proper heading hierarchy
- ✅ Optimized for Go course content

## 🐛 Troubleshooting

### EPUB Not Generated

**Error**: "Pandoc not found"
```bash
# Install Pandoc
sudo apt-get install pandoc  # Ubuntu/Debian
brew install pandoc          # macOS
```

### Virtual Environment Issues

**Error**: ".venv/bin/activate: No such file"
```bash
cd scripts/build_epub
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Poor Code Highlighting

- Verify code blocks use proper fencing: ` ```go ` not ` ```golang `
- Check `default.css` Pygments section (lines 103-197)
- Ensure Pygments is installed: `pip install Pygments`

### Metadata Not Showing

- Edit `scripts/build_epub/metadata.yaml`
- Ensure YAML syntax is valid (check indentation)
- Rebuild EPUB: `./build_epub.sh`

## 📄 License

See [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! To improve the course or build system:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test by building the EPUB
5. Submit a pull request

## 📞 Support

For issues with:
- **Course content**: Submit an issue describing the problem
- **EPUB generation**: Check troubleshooting section above
- **Theme customization**: Edit `scripts/build_epub/themes/default.css`

## 🔗 Resources

- [Pandoc Documentation](https://pandoc.org/)
- [Go Official Documentation](https://golang.org/)
- [EPUB 3.0 Specification](https://www.w3.org/publishing/epub3/)
- [Pygments Lexers](https://pygments.org/lexers/)
