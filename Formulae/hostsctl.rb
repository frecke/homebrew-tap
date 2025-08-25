class Hostsctl < Formula
  desc "Tiny macOS /etc/hosts manager with tag toggles and DNS flush"
  homepage "https://github.com/<YOUR_GH_USERNAME>/hostsctl"
  version "0.1.0"
  url "https://github.com/<YOUR_GH_USERNAME>/hostsctl/releases/download/v#{version}/hostsctl-v#{version}.tar.gz"
  sha256 "<FILL_IN_FROM_release.yml_OUTPUT>"
  license "MIT"

  depends_on "zsh"

  def install
    bin.install "hostsctl/bin/hostsctl.zsh" => "hostsctl"
  end

  test do
    # Run with env to avoid sudo/network
    (testpath/"hosts").write "# base\n127.0.0.1 localhost\n"
    env = { "HOSTS_FILE" => testpath/"hosts", "SUDO" => "", "SKIP_FLUSH" => "1" }
    system env, "#{bin}/hostsctl", "add", "1.2.3.4", "example.com", "-t", "demo"
    assert_match "# hs:demo", (testpath/"hosts").read
  end
end