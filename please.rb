class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.4.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.4"
    cellar :any_skip_relocation
    sha256 "dc4c9a134b3ae2cfc36cf0639068588451f3e95513e932b82f21b7dab07e62b3" => :el_capitan
    sha256 "0dce87be72dbb83ca513f40c51d156744c0fc1f97ae18bf955e45bc5b36df61b" => :yosemite
    sha256 "b50435c1c0eed5a6ae56a969c2abd2e18ee981520708f21081b211af894bf49b" => :mojave
    sha256 "dc1284e96e4a57a0a02fe853dc0bc5e3a92b0e018e938f4ebf64b03cabf6838d" => :linux_x86_64
  end
end
