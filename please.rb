# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.20.1.tar.gz"
  sha256 "7b0b805e48dd2781e69a7e7340e520e1c7c931d5ce3f296f73ec8c9d603de560"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.20.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "9a150df7e5a95aa708a98ee7647f9d5195e8f66e465e351bcd6bf8a1d45de401"
    sha256 cellar: :any_skip_relocation, yosemite: "1b19a23d27d3d600287eb62b4a19f5999cef0bb990e39db1d28ebf5241fc7941"
    sha256 cellar: :any_skip_relocation, mojave: "eeb69ede648f629c1b14a69fbbaf1238f082704a59af00edca8b5e643dc3c7c7"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "4e205b520832a4ef13b2e83e3e6751e8bf53be0c07ce8941bbc80b3e407a599f"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/bin/package/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
