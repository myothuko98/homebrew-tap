class GitExplain < Formula
  desc "Understand why code changed, not just when — AI-powered git history explainer"
  homepage "https://github.com/myothuko98/git-explain"
  url "https://github.com/myothuko98/git-explain/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "9732c79a2fd3667a424fdc61768bba08f6947fa647b894d4270c6c2f08a02c46"
  license "MIT"
  head "https://github.com/myothuko98/git-explain.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/git-explain"
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
    assert_match version.to_s, shell_output("#{bin}/git-explain --version")
  end
end
