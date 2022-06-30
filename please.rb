# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.21.3.tar.gz"
  sha256 "cf89880a13cb042f42d7af7482a69c97692ecbb453af5575ecd75376e266b0df"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.21.3"
    sha256 cellar: :any_skip_relocation, el_capitan: "5a95d46e2e2e79239ce27fe60efab22e860855a9626592396b8d5144eca33d31"
    sha256 cellar: :any_skip_relocation, yosemite: "765dbf49201355670a90c93575c9c9fc8a8ecee0aa6d065181fc921a0879a1a7"
    sha256 cellar: :any_skip_relocation, mojave: "59b033180200efb68e306bd133093559f9c20bb5b72e9db33508657b8b9e09e9"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "3cfc03e6f9ad26c27a99de11b57e24fe58fe575d53334f45e53e81f772607660"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/bin/src/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
