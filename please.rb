class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.1"
    cellar :any_skip_relocation
    sha256 "21e3bd4eb58a9704af23d29de879b12c42918673b09332c59ed5f0c34e2dd04e" => :el_capitan
    sha256 "c2a22a8b3592f384f75aeaa075cf2fd947f27ec04d982597a86887d91f226149" => :yosemite
    sha256 "e464eebaf13af41893212bf0391e0b6b219f1adbbfabe462affee5cc6e561411" => :mojave
    sha256 "4b025c53e7cfa3c8d8320393542e506e9b1dcba9888aa66446bfdb96493e81c3" => :linux_x86_64
  end
end
