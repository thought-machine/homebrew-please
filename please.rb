# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.27.2.tar.gz"
  sha256 "6f1039bb33e69d451c377d24acc351f77e7b14faa4f177eb4339569a7db34b50"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.27.2"
    sha256 cellar: :any_skip_relocation, el_capitan: "3033118b9596cc24419ff085299891bd127d2836819b16aec8dd5bc5d7ee4394"
    sha256 cellar: :any_skip_relocation, yosemite: "0c2cc8f2b50166ec820d3539d9ab068442a4e19d00832247da73fee34405f840"
    sha256 cellar: :any_skip_relocation, mojave: "e2136c0c1bc10252cc97a1da15d17f0028ac9fe088db4fd235d01bbf2c25c984"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "1ee4bb630f6c9325b6e8e1721fe0a2f3b2381e39af6f1e52e5d6c99d483dd565"
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
