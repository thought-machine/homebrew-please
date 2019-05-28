class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.8.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.8.1"
    cellar :any_skip_relocation
    sha256 "69d7fbdad09374f43e8cc37110f91c2773530427dbe9ec412f2c9b7185f23025" => :el_capitan
    sha256 "c5048de588cd1abb2ed7e2a0973397fdb75350afc7dd95d903d7eae0220bb395" => :yosemite
    sha256 "03bda15707363e556f535dae7b3c1655ddc13d28961a72592d33c8182c3c6d42" => :mojave
    sha256 "24cd911dd821eb47091a1a0a4a03701db3668437b601b8885ae4f246e824a16b" => :linux_x86_64
  end
end
