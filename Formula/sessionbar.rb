class Sessionbar < Formula
  desc "macOS menu bar status for all active Claude Code sessions"
  homepage "https://github.com/nvdson2005/sessionbar"
  url "https://github.com/nvdson2005/sessionbar/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "10f71008013d7dc540c0d07db7c87203aaae59a1e51272f729ebd3f5f69cce32"
  license "MIT"
  head "https://github.com/nvdson2005/sessionbar.git", branch: "main"

  depends_on "jq"
  depends_on :macos

  def install
    bin.install "bin/sessionbar"
    pkgshare.install "swiftbar"
  end

  def caveats
    <<~EOS
      sessionbar needs SwiftBar to draw the menu bar item:
        brew install --cask swiftbar
      Open SwiftBar once and choose a plugin folder, then run:
        sessionbar setup
      This installs the Claude Code plugin (hooks) and the SwiftBar plugin.
      Restart running Claude Code sessions afterwards.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessionbar --version")
    ENV["SESSIONBAR_DIR"] = testpath/"state"
    assert_match "No active Claude sessions", shell_output("#{bin}/sessionbar status")
    assert_match "sfimage=sparkle", shell_output("#{bin}/sessionbar swiftbar")
  end
end
