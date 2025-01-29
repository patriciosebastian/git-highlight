
# git-highlight



**git-highlight** is a Zsh plugin that highlights your Git commands in real-time. It highlights:

- **Valid commands** in green.
- **Partially matched sub-commands** in yellow.
- **Invalid commands** in red.

## Features

- **Real-Time Highlights:** Instantly highlights your Git commands as you type.
- **Cross-Platform:** Zsh Works seamlessly on macOS, Linux, and Windows (via WSL).
- **Customizable:** Tailor it to your workflow with powerful customization options.



## Demo Video

[![git-highlight Demo Video]](https://patriciosebastian.github.io/git-highlight-website/git-highlight.mp4)

---

## Installation

### Manual Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/patriciosebastian/git-highlight.git ~/.git-highlight
   ```

2. Add the script to your `.zshrc` file:

	This will source the git-highlight script on every new Zsh session, ensuring the highlighting feature is always active:

   ```bash
   echo "" >> ~/.zshrc && echo "source ~/.git-highlight/git-highlight.zsh" >> ~/.zshrc
   source ~/.zshrc
   ```

	If you'd rather add it manually, just open your `.zshrc` (located in your home directory) and append:

	```
	source ~/.git-highlight/git-highlight.zsh
	```

3. Refresh your terminal:

   ```bash
   source ~/.zshrc
   ```

### Using a Zsh Plugin Manager

If you’re using a Zsh plugin manager like [zplug](https://github.com/zplug/zplug), add the following line to your `.zshrc` file:

```bash
zplug "patriciosebastian/git-highlight"
```

Then, reload your terminal:

```bash
source ~/.zshrc
```

## Customization

You can customize Git Highlight by editing the `git-highlight.zsh` file.

### Modify Valid Git Commands

To add or remove recognized commands, edit the `validGitCommands` array:

```bash
typeset -a validGitCommands=(git init commit push pull status checkout merge branch fetch rebase diff add log stash pop restore reset)
```

Add more commands:

```bash
validGitCommands+=(blame cherry-pick worktree)
```

### Update Shell Operators

To handle additional shell operators, edit the case block:

```bash
case "$word" in
  '&&'|'||'|';'|'&')
    expect_subcommand=false
    ;;
esac
```


## Contributing

I welcome contributions! To contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a clear description of the changes.


## Like This Tool?

If you found git-highlight helpful, consider supporting with a small tip:
[![Buy Me A Coffee ](https://img.shields.io/badge/Support-My%20Buy%20Me%20A%20Coffee-blue)](https://patriciosalazar.kit.com/products/buy-me-a-coffee
)
