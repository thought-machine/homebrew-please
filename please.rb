# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.17.1.tar.gz"
  sha256 "e9ebbe480eadbb6b15e98a51ffd2b345044a766789c3dca3dc8621c2dca765e0"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.17.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "f41060507cd33ff08671d4d8627c89f5149dae96d0bafbcc3d5d17dfe7542bb8"
    sha256 cellar: :any_skip_relocation, yosemite: "7c3721e7102a94f7390ad93530cea7c3a66e70336c303709d5a240eec4f7d239"
    sha256 cellar: :any_skip_relocation, mojave: "47f91086ec91e72de200716264a0947e48668aa59cf708b0429bfb11091bf4f3"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "f01c1cc01280420f8e613a9906f23116e57ca9e3383eb23efc7effd12525c17d"
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
