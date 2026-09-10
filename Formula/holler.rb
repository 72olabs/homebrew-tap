class Holler < Formula
  desc "Durable local messaging for terminal agents"
  homepage "https://github.com/72olabs/holler"
  url "https://github.com/72olabs/holler/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "287a03ec197c3efd3fd3cea27240d5c6f0780ae6c1fcbd06889e6fb3b35a994d"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    commit = "ba7375c7ce3e4859a214831c129c42d9dd08b4e8"
    built_at = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    ldflags = %W[
      -s -w
      -X github.com/72olabs/holler/internal/buildinfo.Version=#{version}
      -X github.com/72olabs/holler/internal/buildinfo.Commit=#{commit}
      -X github.com/72olabs/holler/internal/buildinfo.Dirty=false
      -X github.com/72olabs/holler/internal/buildinfo.BuiltAt=#{built_at}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"holler", "./cmd/holler"
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"hollerd", "./cmd/hollerd"

    marketplace = pkgshare/"marketplace"
    marketplace.install "connectors/marketplace/.agents", "connectors/marketplace/.claude-plugin"
    (marketplace/"plugins").install "connectors/marketplace/plugins/holler"
    (marketplace/"plugins").install "connectors/marketplace/plugins/claude-holler"
    (marketplace/"plugins").install "connectors/marketplace/plugins/opencode-holler"
    doc.install "README.md", "RELEASE-NOTES.md", "SECURITY.md"
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
