class Draai < Formula
  desc "Play your local music on Sonos, IKEA Symfonisk and Chromecast speakers"
  homepage "https://github.com/itsmesaskovic/draai"
  url "https://github.com/itsmesaskovic/draai/releases/download/v2.8.0/draai.pyz"
  sha256 "1649e6a8ce850845707283143359621ae42f0d88d8db4ce1440a0816380ed21d"
  license "MIT"

  bottle do
    root_url "https://github.com/itsmesaskovic/homebrew-draai/releases/download/draai-2.8.0"
    sha256 cellar: :any_skip_relocation, all: "a4a23d27638c9d23e86e5945adb9625f99e874344a953a80862901f7b56ede1f"
  end

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
      Then open it:
        draai
      Then click "Install DRAAI" in Chrome's address bar
      (Safari: File > Add to Dock) to keep DRAAI in your Dock.

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
