class Draai < Formula
  desc "Play your local music on Sonos, IKEA Symfonisk and Chromecast speakers"
  homepage "https://github.com/itsmesaskovic/draai"
  url "https://github.com/itsmesaskovic/draai/releases/download/v2.8.3/draai.pyz"
  sha256 "00171d5d16c6a2ca1d5d8bd8a8f89b9fd40327e96bf899b7381de61bcc4fd97a"
  license "MIT"

  bottle do
    root_url "https://github.com/itsmesaskovic/homebrew-draai/releases/download/draai-2.8.3"
    sha256 cellar: :any_skip_relocation, all: "ebe41f2979191cdb7872e7ec23aacfc229a7622263e7ba7326e020eb5b633831"
  end

  depends_on "python@3.14"
  depends_on "ffmpeg" => :recommended

  def install
    libexec.install "draai.pyz"
    (bin/"draai").write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("python@3.14")}/python3.14" "#{opt_libexec}/draai.pyz" "$@"
    SH
    chmod 0755, bin/"draai"
  end

  def caveats
    <<~EOS
      Run DRAAI in the background and at every login:
        brew services start draai
      Then open it:
        draai
      Then click "Install DRAAI" in Chrome's address bar
      (Safari: File > Add to Dock) to keep DRAAI in your Dock.

      Importing from a link uses yt-dlp. DRAAI explains it and offers to
      install it in the sidebar, or run:  brew install yt-dlp

      Update with:
        brew upgrade draai
    EOS
  end

  service do
    run [opt_bin/"draai", "--headless"]
    keep_alive true
    working_dir var
    log_path var/"log/draai.log"
    error_log_path var/"log/draai.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/draai --version")
  end
end
