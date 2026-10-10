class Holler < Formula
  desc "Durable local messaging for terminal agents"
  homepage "https://getholler.ai"
  license :cannot_represent
  revision 1

  on_macos do
    on_arm do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.2/holler-0.8.2-darwin-arm64.tar.gz"
      sha256 "7b395c194999932308e8fa6ccc301a70c4a6e5c93f699a429d57b8242e2350a6"
    end
    on_intel do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.2/holler-0.8.2-darwin-amd64.tar.gz"
      sha256 "1b9b94b5c57610c6d169ea207122804ab18cfcb2f807f720a8d9acd8d2b42882"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.2/holler-0.8.2-linux-amd64.tar.gz"
      sha256 "f532b40b7b76c4de63d3977c910fc378e4bdfa22defb415eee195b26d33e070c"
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
