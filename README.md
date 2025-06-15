# Ruby DemoDoc Generator

This project is a **Ruby-based documentation automation tool** that processes `.rb` files, executes them in IRB, cleans the output, and generates well-formatted Markdown documentation.

It also generates an **index** linking to the output files for easy browsing via static site generators like GitHub Pages or Jekyll.

<https://yumayx.github.io/rubydemodoc/>

## Features

- Clean IRB outputs and embed into Markdown
- Auto-generate `.md` files from `.rb` scripts
- Build navigable index of all docs
- Compatible with Jekyll for static site publishing

---

## Getting Started

### 1. Install dependencies

```bash
bundle install
```

### 2. Place source `.rb` and `.md` files

Put your input files under the `input/` directory. Example:

```
input/
└── category/
    ├── example.rb
    └── example.md
```

- `example.rb` will be executed in IRB
- `example.md` is optional and inserted above the IRB result in the output

### 3. Run the default task

```bash
rake
```

This will:

- Clean `output/` directory
- Generate `.md` files per script
- Create an `index.md` linking them

---

## Output Format

Each file generates a Markdown file like:

```markdown
# example.rb

<contents of example.md if exists>

```ruby
#=> cleaned IRB output from example.rb
\```
```

## Use Cases

- Create auto-generated examples from Ruby scripts
- IRB-based code documentation for teaching or reference
- Export Ruby script outputs for blog, site, or reports
- Integrate with Jekyll for live documentation sites

---

## llm

### for mac

```sh
brew install ollama
ollama serve
```

```sh
ollama run gemma3
```

### for linux

```sh
# https://ollama.com
curl -fsSL https://ollama.com/install.sh | sh
ollama run gemma3
```