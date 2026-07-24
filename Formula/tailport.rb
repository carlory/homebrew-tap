class Tailport < Formula
  desc "Automatically expose loopback TCP services over Tailscale"
  homepage "https://github.com/carlory/tailport"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.1/tailport_v0.1.1_Darwin_arm64.tar.gz"
      sha256 "5f25120362caf9d531b6ef418efcb02175f445c99b6770f3f4d99fa695633446"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.1/tailport_v0.1.1_Darwin_x86_64.tar.gz"
      sha256 "bdb77f2de7e3cd23db089796b63593b37d704902d2e2ab410fe937a4f188bf36"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.1/tailport_v0.1.1_Linux_arm64.tar.gz"
      sha256 "2d38dd3e9635ce593b0035513350b3e4f096eed5a2dea71c3a0034b928167680"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.1/tailport_v0.1.1_Linux_x86_64.tar.gz"
      sha256 "1cae3a1ae8d671812f877f6543a301db4c330a94b0adf76a5dfadfd9e86abdc3"
    end
  end

  def install
    bin.install "tailport"
  end

  service do
    run [opt_bin/"tailport", "daemon"]
    keep_alive crashed: true
    process_type :background
    log_path var/"log/tailport.log"
    error_log_path var/"log/tailport.log"
  end

  test do
    assert_match "tailport v#{version}", shell_output("#{bin}/tailport version")
    assert_match "configuration is valid", shell_output("#{bin}/tailport config validate")
  end
end
