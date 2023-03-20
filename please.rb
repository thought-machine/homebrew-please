# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.28.0.tar.gz"
  sha256 "2e8d833f90f8bf9925f1e9cc8186e7ec7878835d0808c6502f9374ecd242d9b7"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.28.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "8eaae91123aa4495a46ed32f4a42adb5454f24850064d93dbec80138fc9c752c"
    sha256 cellar: :any_skip_relocation, yosemite: "ee7843dffa2b08df2ae337a60f05fa9d164522236860fb9e080f4b6d4bda150f"
    sha256 cellar: :any_skip_relocation, mojave: "db61a818db12c6cd72c94a1ee5c522bf48e10056f2b70ac5e37ec29757b6713a"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "66c4c9daac3fea225db858f2d7908ae6b1a82bee5180867683ecabd0b913b480"
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
