# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.10.1.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.10.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "2c06a1804d614b987059f40fba74fe1a70e8a82958cd5dd296b803b028b501f1"
    sha256 cellar: :any_skip_relocation, yosemite: "21018d682b44067f01047fd29a0fb0c803138584b077ffec67e482b4876d6ff6"
    sha256 cellar: :any_skip_relocation, mojave: "a1a2fc42d6fa7a217ef14d980bda99c445897d36857797b0b9bd6887ae3d0ca4"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "b22e19d68d1b5f416465b63471524e9756ddddffe7c887837cb1a5c1aeb04ac5"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/gen/package/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
