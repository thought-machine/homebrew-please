class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.5.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.5.1"
    cellar :any_skip_relocation
    sha256 "2dc18b8f24b01177623c3a44de98740be8d7c6f25894be3f5080d4f4427a4d80" => :el_capitan
    sha256 "63550b47530f1bf26bab095a3ed669abb328d85f52a142e6f9951f67391f60d4" => :yosemite
    sha256 "a3e3b30e71b9893c38c24d52c5638da552ae34c1361f6f4c1c05b6082734acbc" => :mojave
    sha256 "f350a319947b628f93d3f3a95dc89d436f4b9668dbd08732192feb51d95cfc25" => :linux_x86_64
  end
end
