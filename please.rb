class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.8.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.8.2"
    cellar :any_skip_relocation
    sha256 "86bcaa89a019c040513a5e56b85a8bbba546b1b27e32099aae041bf7d701f09a" => :el_capitan
    sha256 "14ee9bd42452c62879cf7bd98744814e8e9e0b1a2298eacfd07462f9a8296322" => :yosemite
    sha256 "3991d321e42f19832f6484165142b711f0021564c8a576ad6f2b99404da0a984" => :mojave
    sha256 "f6fb64293af29c1ad5baa3f7d6643d920021f685282d652b84fd8593c224f104" => :linux_x86_64
  end
end
