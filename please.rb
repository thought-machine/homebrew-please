class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.15.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  depends_on "go" => :build

  def install
    system "./bootstrap.sh --skip_tests"
    libexec.install Dir["plz-out/gen/package/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz init"
    system "plz build ///pleasings//go:all"
  end

  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.15.0"
    cellar :any_skip_relocation
    sha256 "666369486a3f382b6df2b6f12f3d4877096e19a4d5be94df8112273580f56470" => :el_capitan
    sha256 "ccfc5b0bc0c6c2ea1b5b5ad54ecb3e32b2215096bb3e742d806625cc167be4c7" => :yosemite
    sha256 "185e984c9e81e8b8655e563e55eab6665de157a108ad825a09de63c0f5e305da" => :mojave
    sha256 "becdef4f106cacd58112686fb4b6635a61dd91eef7a686d68fdf7b60b9d53d88" => :linux_x86_64
  end
end
