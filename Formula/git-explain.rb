class GitExplain < Formula
  desc "Understand why code changed, not just when — AI-powered git history explainer"
  homepage "https://github.com/myothuko98/git-explain"
  url "https://github.com/myothuko98/git-explain/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "fadbad0156a730c902be3f3fa14169050f6812756c88779dc6602316c53cff4e"
  license "MIT"
  head "https://github.com/myothuko98/git-explain.git", branch: "main"

  bottle :unneeded

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/git-explain"
  end

  def caveats
    <<~EOS
      git-explain uses a provider fallback chain:
        Ollama (local) → OpenAI → Anthropic → Gemini → Qwen → Moonshot → rule-based

      Zero config required — rule-based analysis works offline with no API key.
      To configure a cloud provider or Ollama, run:
        git-explain setup
    EOS
  end

  test do
    # Verify binary runs and version flag works
    assert_match version.to_s, shell_output("#{bin}/git-explain --version")
  end
end
