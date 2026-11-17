# Homebrew tap for DRAAI

[DRAAI](https://github.com/itsmesaskovic/draai) plays your local music on
Sonos, IKEA Symfonisk and Chromecast speakers. No cloud, no accounts.

```sh
brew install itsmesaskovic/draai/draai
brew services start draai     # runs in the background, starts at login
open http://localhost:8765
```

The full name matters: Homebrew only trusts a third-party formula when you
install it by its full name. After that, the short `draai` works.

Update with `brew upgrade draai`. Run `brew autoupdate start` once if you
want Homebrew to keep it current on its own.

ffmpeg (waveforms and visuals) comes along by default. Importing from a link
needs yt-dlp: DRAAI explains it and offers to install it in the sidebar, or
run `brew install yt-dlp`.

The formula is updated automatically when a DRAAI release is published.
