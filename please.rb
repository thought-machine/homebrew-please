# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.9.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.9.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "96e1f5b0a7a45b4f23874fd0e4c88623f40f2c8be0affebe7720b901c24ae6d6"
    sha256 cellar: :any_skip_relocation, yosemite: "870160b1c51de79a25cdcc1816dfa2ca7b7688d7088e6b7d5551e091763cae3c"
    sha256 cellar: :any_skip_relocation, mojave: "a337f713170e9ebd76a305a723cdebb95dfdf67d74b9d30055b06bc4cb6bf316"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "9762e339bf7146119f536f1a52497f46dc62d8d29be6bfdff8c8ac8b193e28a4"
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
