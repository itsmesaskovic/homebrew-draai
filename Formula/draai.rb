class Draai < Formula
  desc "Play your local music on Sonos, IKEA Symfonisk and Chromecast speakers"
  homepage "https://github.com/itsmesaskovic/draai"
  url "https://github.com/itsmesaskovic/draai/releases/download/v2.8.2/draai.pyz"
  sha256 "60fe0454468c30188bb94126fd2273060cb96cfabc225ccb5e752b5ddd65c122"
  license "MIT"

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
