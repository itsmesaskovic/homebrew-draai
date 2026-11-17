class Draai < Formula
  desc "Play your local music on Sonos, IKEA Symfonisk and Chromecast speakers"
  homepage "https://github.com/itsmesaskovic/draai"
  url "https://github.com/itsmesaskovic/draai/releases/download/v2.7.0/draai.pyz"
  sha256 "2a10d630f3ea27d23d5df1dd00d56f3ab21ccc1d3c54afc152bc49f8ffdd4cab"
  license "MIT"

  depends_on "python@3.14"
  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :optional

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
      Then open the control panel:
        http://localhost:8765

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
