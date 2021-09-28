# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.10.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.10.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "1d38bdbac06b90887512ef25bca36d3aef0cd26d5ab1bec817afe6683d4e0555"
    sha256 cellar: :any_skip_relocation, yosemite: "3a1c7ef56ba9bb8eb9199cb5754909f63b742a9c26c7da0301ac851261747c0e"
    sha256 cellar: :any_skip_relocation, mojave: "f9f17c4ab8bf899aa2a9fcd48e0cea97ceaf7f5313e71d7b076dcec980e06780"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "4616cc01b815d23ef968fd797082ce72baf8ce7f9df77c20acad447d09f2db5f"
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
