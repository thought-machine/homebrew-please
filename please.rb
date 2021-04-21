class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.0.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.0.0"
    cellar :any_skip_relocation
    sha256 "9bee48e802dd21d8db816823407368b032ed95aa4dcff5ff4d21acb013531b28" => :el_capitan
    sha256 "4299aeef9d1ee388e19e042a2fb3968c21d11e923c3278119b06d99ec79b4975" => :yosemite
    sha256 "7adcd8f5edb60b1fcdff1dbc0c9e04d284be80982b75001fa93fd3ed86364a18" => :mojave
    sha256 "cea5e116eea09ecba648aa4ae04902638097f385f9375685e63c789b9dff66be" => :linux_x86_64
  end
end
