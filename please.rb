class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.4.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.4.0"
    cellar :any_skip_relocation
    sha256 "7a9a0c610a9eb6860d25d5298a7ab0956a3426eb16b320e367ea91eafb7e6983" => :el_capitan
    sha256 "30431457f180aaa650bf6e1a54b1c23077852aad10e288908ed541ac35a9e8f6" => :yosemite
    sha256 "cd93ceb0997def7c2ceef3ed53f148fa5934ef2b6fa952beadbe39e1e65a33b2" => :mojave
    sha256 "a2750c05cda90ed01c5fe2c4decf094302f6bd37d4508b65ffc7e55093f428c7" => :linux_x86_64
  end
end
