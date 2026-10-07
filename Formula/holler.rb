class Holler < Formula
  desc "Durable local messaging for terminal agents"
  homepage "https://getholler.ai"
  license :cannot_represent
  revision 1

  on_macos do
    on_arm do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.1/holler-0.8.1-darwin-arm64.tar.gz"
      sha256 "41d122dd8979d2fe50c6f01ed9cd446717f55e2d12275d0c0604bce75af0d18f"
    end
    on_intel do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.1/holler-0.8.1-darwin-amd64.tar.gz"
      sha256 "2861e2fa1608e73ee96df0c577d7ec81ce63ed50d698a512eca758de0975020b"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/72olabs/holler-releases/releases/download/v0.8.1/holler-0.8.1-linux-amd64.tar.gz"
      sha256 "ec180f2b9290f95c21bc03d65fb47808ff4e777e833a3f47f4c9f95115d6800e"
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
