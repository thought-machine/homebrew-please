# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.21.1.tar.gz"
  sha256 "0409ebca8d87ecd1fea15e1d4dbb89f8841c3086992dfb30c5c5bfde82f24d36"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.21.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "ab13bbcca855648dc0def5ed2460ccd926f9c05f3cfe945b68de31fc3648acad"
    sha256 cellar: :any_skip_relocation, yosemite: "66af7ee60795dbc58a2039dae61cad331cbc55f33f976041d80774fc5fdd8e73"
    sha256 cellar: :any_skip_relocation, mojave: "8142ed4d70570f0d6eeec5494658d1f2d55346c77619591339a1faa47c570c79"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "8f3061de712c3c7c07df994921db78cac338547aaa3b236847043881d68abc3d"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/bin/src/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
