class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.2.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.2.1"
    cellar :any_skip_relocation
    sha256 "a23953752900c81b149a249a028d7ce52f31370cf1465555d090c22a25ca39ad" => :el_capitan
    sha256 "c39d4f3d52024700f791fd237962131eefdfb9139e2989e6ba5899615606dedf" => :yosemite
    sha256 "83bd9a283624f62a7f29f8d303aa40e920a46c4b315364bc0d5ddd2481b9dcd9" => :mojave
    sha256 "932bfaf78ca372794503ab4f201621870bf564d6fd09a0c4bf4834604e0b849b" => :linux_x86_64
  end
end
