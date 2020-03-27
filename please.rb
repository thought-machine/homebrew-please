class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.6.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.6"
    cellar :any_skip_relocation
    sha256 "aaf9f181636f1c11f451aa23edc250650a98af75c52b1713cd69300c4dd6b736" => :el_capitan
    sha256 "be399dd8da4a0e69be729a0897bbdf74c1c6e9422faca127eb35a771447e6332" => :yosemite
    sha256 "237cf6ac571a692ab37adcc30517824c6d71c99b5203ba06160e8d2ef91f137c" => :mojave
    sha256 "45b3fb5abfce1a91547c21abb961085c48523d30fe1c33b7df58a0f953b266bc" => :linux_x86_64
  end
end
