class Tailport < Formula
  desc "Automatically expose loopback TCP services over Tailscale"
  homepage "https://github.com/carlory/tailport"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.3/tailport_v0.1.3_Darwin_arm64.tar.gz"
      sha256 "0e1a02a56b4c8f104d95b97a18d69999f2211785a9ccda3f58e6a6b8eb9039a4"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.3/tailport_v0.1.3_Darwin_x86_64.tar.gz"
      sha256 "18fe6e5447126ef8cbb3301f8696e147dcfe713d4e265ca5d17e770e1f3aa743"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.3/tailport_v0.1.3_Linux_arm64.tar.gz"
      sha256 "06ffec07e82f35bcff32c15eb391d041f20969a548033c5bdf1f58841d29c922"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.3/tailport_v0.1.3_Linux_x86_64.tar.gz"
      sha256 "2297df771a740b3ff35902db8bcfa6ca4289511444bcf571aee753fd5ef97f46"
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
