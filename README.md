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

Publish the matching binary release in `72olabs/holler-releases` first. Then
generate the formula from the public, immutable binary archives:

```sh
VERSION=0.8.1
./scripts/publish-holler-formula "$VERSION" proprietary
git add Formula/holler.rb
git commit -m "holler $VERSION"
```

The generator downloads all three platform archives anonymously, verifies their
published checksums, and renders `Formula/holler.rb`. No source checkout, Go
compiler, or GitHub credentials are needed. Linux ARM64 is not currently packaged.

Current Holler releases use the Holler Proprietary Software License. The
publishing helper accepts only `proprietary`, matching the license included
in the binary release.

Open a PR and wait for installation tests on macOS ARM64, macOS Intel and Linux
AMD64 before merging.

## Repository license

The first-party tap files, scripts, and documentation are proprietary. See
[LICENSE](LICENSE); normal installation through Homebrew is permitted.

This repository license does not relicense the software a formula installs.
Each formula's license metadata must match its binary release. Previously
distributed copies retain their original license.
