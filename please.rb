# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.25.0.tar.gz"
  sha256 "f53012113519a96720dc4a8d28c660922d7586dface723c86e34a0c159848659"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.25.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "9ebfaabf10a9901a2e6c136da9692ebb49d8996c12a1004c111868a4c390def3"
    sha256 cellar: :any_skip_relocation, yosemite: "d07f180654863f3bb86bcdee2e49c13e49f7d40077b1a908ff0ec6dce1b3c4aa"
    sha256 cellar: :any_skip_relocation, mojave: "739ed7257033068ba46460cdc6468d661662225eea7538de1303c2d6c1f69db1"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "dab253bb2938cdd5f5bf669f550bcab2dc497461ab45c9fca2bc26c711779dc3"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests", "-p"
    bin.install "plz-out/bin/src/please" => "plz" 
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
