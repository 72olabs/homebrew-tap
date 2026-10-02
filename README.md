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
VERSION=0.8.0
./scripts/publish-holler-formula "$VERSION" Apache-2.0
git add Formula/holler.rb
git commit -m "holler $VERSION"
```

The generator downloads all three platform archives anonymously, verifies their
published checksums, and renders `Formula/holler.rb`. No source checkout, Go
compiler, or GitHub credentials are needed. Linux ARM64 is not currently packaged.

Use the license applicable to the binary release: unchanged 0.8.0 remains
`Apache-2.0`; `proprietary` is available only for future releases with approved
product terms. Formula metadata does not itself change a release's license.

Open a PR and wait for installation tests on macOS ARM64, macOS Intel and Linux
AMD64 before merging. Revision 1 of 0.8.0 migrates existing source-built installs
to the packaged binary without changing Holler's version or deleting its data.
