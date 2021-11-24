# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.15.0.tar.gz"
  sha256 "dc51b28a30128d279e9436e160b3ad247eedb309cd6bb2554fa02ab61544a69a"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.15.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "8c5a74da31790d48d706c9b0f984a60136ecc8bf345a0ed37a2ff8763cb662b7"
    sha256 cellar: :any_skip_relocation, yosemite: "f40d7914306e3d16ba086265b605f5aa9d82bc8bb18abbf6b813cba15bb33945"
    sha256 cellar: :any_skip_relocation, mojave: "83d4bc6b08a64e932495ca21b53f6fdb6b1268c8c540d531825a21dfb3a6d54f"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "a628260e6f550a4eaf0ecbdc1e7d2799c28446ccebcd33264478ed9617722405"
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
