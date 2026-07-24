class Tailport < Formula
  desc "Automatically expose loopback TCP services over Tailscale"
  homepage "https://github.com/carlory/tailport"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.0/tailport_v0.1.0_Darwin_arm64.tar.gz"
      sha256 "f26620541aa0e832b27e40e10ca09595a83a3a3714546b92d61f3e2445e18a66"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.0/tailport_v0.1.0_Darwin_x86_64.tar.gz"
      sha256 "6b45eeb50c315c6241a88b5c83b330a226f5d91499b5d36b08a5f6a4fd132013"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.0/tailport_v0.1.0_Linux_arm64.tar.gz"
      sha256 "1ab1e762194649ea4d06a2d9bdf73e5c635cfa6cbc45fc332b6ebaf940f98b45"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.0/tailport_v0.1.0_Linux_x86_64.tar.gz"
      sha256 "6956c06ab745c8fac0db18c473360c6301ca624c72cd0407dd3ebb59bb989a01"
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
