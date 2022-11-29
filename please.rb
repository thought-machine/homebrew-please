# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.25.1.tar.gz"
  sha256 "ea109624f3d6272c5d72e6bc8f500d9017df6851cef2a964fd524559ad83cd09"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.25.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "5476c11ee2573e384605fd597672e41f89e5e8ad19c6dc4b2f715b0195d7485f"
    sha256 cellar: :any_skip_relocation, yosemite: "d682f9fcb59b40d26f620e0cc6b35fc2aa5160a70f1164b26fe76c4061672159"
    sha256 cellar: :any_skip_relocation, mojave: "67df279e1150ea3b6e6027f81eec81673623e13199ed543e1a5c0a90c320e281"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "7b046bc70373302c3e38b6fdcdce69a8168071de599077a8b18c8016d30f4860"
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
