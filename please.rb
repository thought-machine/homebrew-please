class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.8.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.8.2"
    cellar :any_skip_relocation
    sha256 "2ec8ac1b414f0f3919253c2caad409957a60723381753fd4b472f4e9e831220b" => :el_capitan
    sha256 "c92c2de32e6ff25bd1d999985216cff9beaacb1289cf3b79420b957204833b97" => :yosemite
    sha256 "500282a3b99ba3c9afcde2b8de14798c23d8a926be541fa5d425ab4c89ca895f" => :mojave
    sha256 "f832277a8d3b289263205f94a38601d84a835fea4c7cedef0def3606db59943e" => :linux_x86_64
  end
end
