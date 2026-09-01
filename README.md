# 72o Labs Homebrew Tap

Homebrew formulas maintained by [72o Labs](https://github.com/72olabs).

## Holler

Install Holler:

```sh
brew install 72olabs/tap/holler
```

Configure each agent harness once:

```sh
holler setup claude
holler setup codex
```

After setup, start Claude or Codex normally.

## Publishing a Holler version

Publish the matching tag in `72olabs/holler` first. Then generate the formula
from that immutable GitHub source archive:

```sh
VERSION=0.2.0
./scripts/publish-holler-formula "$VERSION"
git add Formula/holler.rb
git commit -m "holler $VERSION"
```

The generator downloads the tag archive, calculates its SHA-256 checksum, and
renders `Formula/holler.rb` from the tracked template. Do not guess the checksum
or reuse the checksum of a separately packaged binary archive.
