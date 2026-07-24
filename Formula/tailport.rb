class Tailport < Formula
  desc "Automatically expose loopback TCP services over Tailscale"
  homepage "https://github.com/carlory/tailport"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.2/tailport_v0.1.2_Darwin_arm64.tar.gz"
      sha256 "76d5a4632e16a98b5eae279ae2fcc4cb2ddd871e59fb84af552ec1ec07e3cebd"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.2/tailport_v0.1.2_Darwin_x86_64.tar.gz"
      sha256 "e8bdbfce9bf3a027ff137a4af0d36bcac3fd3cf1de7879c94756037bb148f4d7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/carlory/tailport/releases/download/v0.1.2/tailport_v0.1.2_Linux_arm64.tar.gz"
      sha256 "fa1c296979980a842423739264df748b45f35b241de215cf23438fae8821f9bc"
    else
      url "https://github.com/carlory/tailport/releases/download/v0.1.2/tailport_v0.1.2_Linux_x86_64.tar.gz"
      sha256 "2cf33a3a4b96baf08c4379c0d55d9be0ddf5ea3d6cf1fee8b8d345caeebe5326"
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
