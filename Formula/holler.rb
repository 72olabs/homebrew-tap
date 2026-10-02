class Holler < Formula
  desc "Durable local messaging for terminal agents"
  homepage "https://holler.72olabs.ai"
  version "0.8.0"
  license "Apache-2.0"
  revision 1

  on_macos do
    on_arm do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.0/holler-0.8.0-darwin-arm64.tar.gz"
      sha256 "f4f536bdf9c6a302652ab19c06edac9deeb8afd642a78efb1eb7d74e14e28c5c"
    end
    on_intel do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.0/holler-0.8.0-darwin-amd64.tar.gz"
      sha256 "132866e070f970123f8822ce89b63a9336ff08291a7c3522d0f5acce7bb566f5"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.0/holler-0.8.0-linux-amd64.tar.gz"
      sha256 "63fea1115de69539bfda5aa72b3bdaccc5e7cd49b2e7e77e61b2ee795bade3c7"
    end
  end

  def install
    bin.install "bin/holler", "bin/hollerd"
    pkgshare.install "share/holler/marketplace"
    doc.install "README.md", "RELEASE-NOTES.md", "SECURITY.md", "CONVERSATIONS.md", "LICENSE"
  end

  def caveats
    <<~EOS
      Configure each harness once after install or upgrade:
        holler setup claude
        holler setup codex

      Before uninstalling the formula, remove each configured harness:
        holler setup claude --remove
        holler setup codex --remove
    EOS
  end

  test do
    assert_match "local agent communication CLI", shell_output("#{bin}/holler help")
    assert_match version.to_s, shell_output("#{bin}/holler version")
    assert_predicate bin/"hollerd", :executable?
    assert_predicate pkgshare/"marketplace/plugins/opencode-holler/connector.json", :file?
  end
end
