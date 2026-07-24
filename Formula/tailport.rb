class Tailport < Formula
  desc "Automatically expose loopback TCP services over Tailscale"
  homepage "https://github.com/carlory/tailport"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.4/tailport_v0.1.4_Darwin_arm64.tar.gz"
      sha256 "e9012bf1a4da23ac733f0c8a2cae0b3da60308f14495efd9dd09e94f732cffcc"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.4/tailport_v0.1.4_Darwin_x86_64.tar.gz"
      sha256 "2fb3d3af704004d8367a0ac5af454d3ad2498100f92a03d5ad3ca43822acc092"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.4/tailport_v0.1.4_Linux_arm64.tar.gz"
      sha256 "93b3c83cc7bac9beeb9491e63e2bf2915e0cb968e907366fc3469426e6f6eb92"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.4/tailport_v0.1.4_Linux_x86_64.tar.gz"
      sha256 "a2621827a5ea46a1a9f946845b8cd5b3fb994be559a8a7432afb087edbd50373"
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
