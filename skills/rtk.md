---
name: rtk-optimizer
description: 'Use RTK subcommands (not wrap) for high-verbosity shell commands to reduce token consumption. Use when running git log, git diff, rspec, rubocop, docker compose, cargo test, pytest, or other verbose CLI output that wastes context window tokens.'
version: 2.0.0
tags: [optimization, tokens, efficiency, git, ruby]
effort: low
---

# RTK Optimizer Skill

**Purpose**: Use RTK (Rust Token Killer) subcommands to compress verbose CLI output before it reaches the agent context.

## Important: No More `rtk wrap`

RTK **0.24+** removed the generic `rtk wrap` pattern. Commands now use **dedicated subcommands**:

```bash
# Old (removed)          →  New (current)
rtk wrap git status      →  rtk git status
rtk wrap cargo test      →  rtk cargo test
rtk wrap pytest          →  rtk pytest
```

If unsure whether a command has an RTK equivalent, use:

```bash
rtk rewrite git status          # prints: rtk git status (exit 0)
rtk rewrite unknown-cmd         # no output (exit 1) — run raw or use rtk summary
```

## How It Works

1. **Detect high-verbosity commands** before executing
2. **Prefix with the matching RTK subcommand** (do not ask for confirmation)
3. **Optionally install the auto-rewrite hook** so Bash calls are rewritten transparently
4. **Track savings** with `rtk gain`

## Two Usage Modes

### Mode 1 — Direct subcommands (always works)

The agent calls RTK explicitly:

```bash
rtk git log -n 20
rtk git diff
rtk rspec spec/models/user_spec.rb
rtk docker compose exec -T web bundle exec rubocop app/
```

### Mode 2 — Auto-rewrite hook (transparent)

Install once; Bash tool calls are rewritten before execution:

```bash
rtk init -g --agent cursor    # Cursor Agent
rtk init -g                   # Claude Code / Copilot
rtk init --show               # Verify hook status
```

After hook install, `git status` becomes `rtk git status` automatically.

**Hook limitation**: Built-in IDE tools (`Read`, `Grep`, `Glob`) bypass the hook. For compact output, use shell equivalents or RTK directly:

```bash
rtk read path/to/file.rb      # instead of Read on large files
rtk rg "pattern" .              # instead of Grep on large repos
rtk find -name "*.rb" .         # instead of Glob via find
```

## Supported Commands

### Git (>70% output reduction)

```bash
rtk git status
rtk git log -n 20
rtk git diff
rtk git show
rtk git branch
```

### Ruby / Rails (RDStation)

```bash
rtk rspec spec/path/to_spec.rb
rtk rubocop app/models/user.rb
rtk rubocop -A app/models/user.rb
rtk rake test
rtk docker compose exec -T web bundle exec rspec spec/...
rtk docker compose exec -T web bundle exec rubocop -A ...
```

### File Operations

```bash
rtk ls .
rtk read path/to/large_file.rb
rtk read path/to/file.rb -l aggressive   # signatures only
rtk find -name "*.rb" .
rtk grep "pattern" .
rtk rg "pattern" .
rtk diff file1 file2
```

### JS/TS Stack (70–90% reduction)

```bash
rtk pnpm list
rtk vitest run
rtk jest
rtk tsc
rtk lint
rtk next build
```

### Rust Toolchain (80–90% reduction)

```bash
rtk cargo test
rtk cargo build
rtk cargo clippy
```

### Python & Go (90% reduction)

```bash
rtk pytest
rtk ruff check
rtk go test ./...
```

### GitHub CLI (79–87% reduction)

```bash
rtk gh pr view
rtk gh pr checks
rtk gh pr list
```

### Docker / Containers

```bash
rtk docker ps
rtk docker logs <container>
rtk docker compose ps
rtk docker compose exec -T web <command>
```

### Generic Fallbacks

```bash
rtk test <cmd>       # any test runner — failures only
rtk err <cmd>        # any command — errors/warnings only
rtk summary <cmd>    # heuristic 2-line summary
rtk run <cmd>        # raw execution, no filtering
rtk proxy <cmd>      # raw execution + usage tracking
```

## Agent Workflow

When about to run a verbose command:

1. Check if an RTK subcommand exists (`rtk --help` or `rtk rewrite "<cmd>"`)
2. Run the RTK version directly — **do not ask the user for permission**
3. Skip RTK for tiny outputs (<100 chars) or interactive commands
4. Prefer `rtk rg` / `rtk read` over native Grep/Read tools on large outputs

```markdown
# Example internal decision:

User asks: "Show git history"
→ Run: rtk git log -n 20

User asks: "Run the failing spec"
→ Run: rtk docker compose exec -T web bundle exec rspec spec/foo_spec.rb
```

## Installation Check

```bash
rtk --version   # Should output: rtk 0.37.0+ (current: 0.44.0)
rtk gain        # Must show savings dashboard — confirms correct RTK (not Rust Type Kit)
```

If `rtk gain` fails but `rtk --version` works, you have the **wrong** RTK package. Reinstall:

```bash
# Homebrew (recommended)
brew install rtk

# Quick install (Linux/macOS)
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh

# Cargo (must use git, not crates.io — name collision with Rust Type Kit)
cargo install --git https://github.com/rtk-ai/rtk
```

## Cursor Setup

```bash
rtk init -g --agent cursor   # Installs preToolUse hook in hooks.json
rtk init --show              # Verify: [ok] Cursor hook
# Restart Cursor after install
```

## Global Flags

```bash
--ultra-compact    # Further output compression (ASCII icons, inline format)
-v, -vv, -vvv      # Verbosity (must appear before subcommand)
```

## Session Tracking

```bash
rtk gain                  # Total savings summary
rtk gain --history        # Recent command history
rtk discover              # Find missed RTK opportunities
rtk session               # RTK adoption across sessions
```

## Edge Cases

- **Small outputs** (<100 chars): skip RTK — overhead not worth it
- **Interactive commands**: skip RTK (git rebase -i, vim, etc.)
- **No RTK equivalent**: run raw, or use `rtk summary` / `rtk err` / `rtk test`
- **Piped commands**: use `rtk pipe` for stdin filtering
- **Built-in IDE tools**: Read/Grep/Glob are not auto-rewritten — prefer `rtk read`, `rtk rg`, `rtk find` for large outputs

## Recommendation

**Use RTK for**: git, rspec, rubocop, docker compose, test runners, linters, file search/read on large outputs

**Skip RTK for**: small outputs, interactive commands, commands with no RTK subcommand

## References

- RTK GitHub: https://github.com/rtk-ai/rtk
- RTK Website: https://www.rtk-ai.app/
- Install guide: https://github.com/rtk-ai/rtk/blob/master/INSTALL.md
