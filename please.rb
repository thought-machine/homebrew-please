# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.8.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.8.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "a8552d91c17f6c721de283e5b6fb228ec283506862a721fd96e1542c87d36747"
    sha256 cellar: :any_skip_relocation, yosemite: "8ffa077be34f5d9104642c430e602b8fadefb45a1ef8dcfad4835e409fa23971"
    sha256 cellar: :any_skip_relocation, mojave: "fa98667acf5337c4ed29e823a319bb6da8e4d719ea9197f348d711cb75602f06"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "beff7f96e4d89b372b808db21eba29328eab1e940c3cbcaf25a1509cb66ff224"
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
