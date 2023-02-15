# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.27.3.tar.gz"
  sha256 "2755c20420a6f121b9dfc7d535be6bb2ab17fb33b366b5454751ae2b57200db9"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.27.3"
    sha256 cellar: :any_skip_relocation, el_capitan: "b90e62143aec9514f11a1b50c8bd7c8ab984fec9ef32563997d9087ad5783770"
    sha256 cellar: :any_skip_relocation, yosemite: "a52e78432a970492ae2ecf5576fa7bad88c04e8eac436a166926dc151d7232d5"
    sha256 cellar: :any_skip_relocation, mojave: "683bce41139182bfdf821081a3bc606b9faad30605b98d521c06fe6078a256da"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "7b9f5038ba7c76db425249369d75e2d693415784f2b64ff5054a7cf2bc120913"
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
