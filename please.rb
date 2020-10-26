class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.7.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.7.1"
    cellar :any_skip_relocation
    sha256 "a13a20d650c547102ec676a31322a58a797f479e0a4e1634f509d246a97774d2" => :el_capitan
    sha256 "bf2b9054ea661f973433139847d9547b69ea3bf4fd43bccaa0ec9eb840fc461c" => :yosemite
    sha256 "a595419dce31d9c0146be471a4707c0d3967db3c7d11729aecc19a1ee95fcdbe" => :mojave
    sha256 "92f0adf09d9acb03e282a461154bec51b289ef9e0b5c0858b7e07273525494ae" => :linux_x86_64
  end
end
