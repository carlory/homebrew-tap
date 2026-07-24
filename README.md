# Homebrew Tap for Tailport

Install [Tailport](https://github.com/carlory/tailport) and run it as a
user-level background service:

```sh
brew install carlory/tap/tailport
tailport doctor
brew services start carlory/tap/tailport
```

Upgrade and restart:

```sh
brew update
brew upgrade carlory/tap/tailport
brew services restart carlory/tap/tailport
```
