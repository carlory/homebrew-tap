class Tailport < Formula
  desc "Automatically expose loopback TCP services over Tailscale"
  homepage "https://github.com/carlory/tailport"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.2.0/tailport_v0.2.0_Darwin_arm64.tar.gz"
      sha256 "b98af2aca479125a9a08de7dc72d739b64704676d5efa024c3cc1d5af9d65b97"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.2.0/tailport_v0.2.0_Darwin_x86_64.tar.gz"
      sha256 "8948903911514a534bd7d6d89c7ea1284ceed9ac15e21e694e34412b8f5c0f0e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.2.0/tailport_v0.2.0_Linux_arm64.tar.gz"
      sha256 "c6122dd571d7db9f376b7a99f2c4baef84d8ec0b5d081bccdcc821324f42ebc5"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.2.0/tailport_v0.2.0_Linux_x86_64.tar.gz"
      sha256 "1050d68db9f7250d0c2b5c12e3deebfb851e132fcc47ee13c3ee0a63969eb4b9"
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
    assert_match "Configuration is valid", shell_output("#{bin}/tailport config validate")
  end
end
