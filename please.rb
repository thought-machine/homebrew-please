class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.4.4.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.4.4"
    cellar :any_skip_relocation
    sha256 "f48c6a06183ef5e04cfc1c50cfd3c2577b698a3b8d7355745878c931df892a04" => :el_capitan
    sha256 "f4a03b967c92b48236d2288d5743d0f7831c2825326febc487cc00c93f225388" => :yosemite
    sha256 "4d22c8480a073f7d26d429e9ab3220348093179a191660569267f67b4dfcf085" => :mojave
    sha256 "9a7048c38d94b3a2571daa829c06c814b3f9fdb9ec0460203aca681e296b9050" => :linux_x86_64
  end
end
