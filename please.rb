class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.11.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.11"
    cellar :any_skip_relocation
    sha256 "919243ab630fbb7f70d940f938fae72b25b61ba0881ce624ec11993cf2ff7297" => :el_capitan
    sha256 "caa88a53bd76c00bd9c33745ffa7d717123c70e70837bb8e85cc817bd22a8adf" => :yosemite
    sha256 "ceaa2236175fa9b2936df509e27cd4637ce59181b2a4dcfbe506cd6570cf3096" => :mojave
    sha256 "ba10eca3b6d1f7edb5c52cdb9191075feae39ee1350fac599e0eee2f07ced90d" => :linux_x86_64
  end
end
