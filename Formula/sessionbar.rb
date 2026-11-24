class Sessionbar < Formula
  desc "macOS menu bar status for active coding agent sessions"
  homepage "https://github.com/nvdson2005/sessionbar"
  url "https://github.com/nvdson2005/sessionbar/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "0fd9950d9eb3466ca15b9ea2752c09da2f29785ea038cd9eb0e95019ba62cdd6"
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
      This installs Claude Code hooks when Claude Code is available, and the SwiftBar plugin.
      Restart running Claude Code sessions afterwards.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sessionbar --version")
    ENV["SESSIONBAR_DIR"] = testpath/"state"
    assert_match(/\A\[/, shell_output("#{bin}/sessionbar status --json"))
    assert_match "sfimage=sparkle", shell_output("#{bin}/sessionbar swiftbar")
  end
end
