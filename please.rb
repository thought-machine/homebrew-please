class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.2"
    cellar :any_skip_relocation
    sha256 "554e864ff0f5cc880757e9bc9f04a276cde7c1d409a93fcc1753295d77ab4e01" => :el_capitan
    sha256 "32d97c784a0b800a88004c2b4c843e628a4942647a22f2ce6163bdfaf4d0c32c" => :yosemite
    sha256 "af0c18c67ee2a69b030d507aeac177d551d308fc854c8bcd7018ba3db73d37c8" => :mojave
    sha256 "36b1008b395da0c4d18ee6ba60f91a3e4d07fcc043263bf675a65c12c1c37d50" => :linux_x86_64
  end
end
