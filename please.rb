class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.1.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.1.0"
    cellar :any_skip_relocation
    sha256 "2be34b5e71b8201a94bd19e08b67edd5e78c668d15c7616ce88720c2c7811087" => :el_capitan
    sha256 "f0bc695c31b01fb257fa461447ac3546b06008bb23307fad65cda96bb7d2bb4d" => :yosemite
    sha256 "72f69e9ae7ed9703d0a463cc8a0c1c5d07fa5a1659ac73ad44b9a3febd1b84b8" => :mojave
    sha256 "1d97ff2b5c884de1886d35f3439bc88a3d4f18116007db8aea361c4b47372317" => :linux_x86_64
  end
end
