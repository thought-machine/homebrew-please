class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.4.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.4.1"
    cellar :any_skip_relocation
    sha256 "e748c8ee9a84020c0cdb9f4f9517faac0d869cbb0b1d104ae779d37350931d34" => :el_capitan
    sha256 "7fb862101ee49430ebf1439d013c6385f91ebf54390eb3a98e05007b7e9ff09a" => :yosemite
    sha256 "96e2205252189df2c784b43afc070d99bb49fcafd7678a11b098532731ce0de4" => :mojave
    sha256 "dfd1fa4d94ddba30bf49d54bf7946d73e6875798afb639002becba1ce55c33cf" => :linux_x86_64
  end
end
