# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.27.5.tar.gz"
  sha256 "5e3b298870ce1f15b4b5b40ca6e9bbd6bac532ffba8b3ba5aec018256278b794"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.27.5"
    sha256 cellar: :any_skip_relocation, el_capitan: "82215dd74c26fb2e18a49972f609bc67148c69dc5dac72da35091aeae4970f19"
    sha256 cellar: :any_skip_relocation, yosemite: "0253bf7b954adaa98b533c7cc3dc46b8c48616c5adad35614343083f905ae2cc"
    sha256 cellar: :any_skip_relocation, mojave: "9a7eb5e35463222e91cb5355690173cee352a51dbc6fee7981fbb7c54c54cab1"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "aa8014f0e1ff1194bfa2ef89b788ffa94253d994e6920c39c456b16ff3ee5d2d"
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
