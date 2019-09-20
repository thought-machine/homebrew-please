class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.5.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.5"
    cellar :any_skip_relocation
    sha256 "935f78b1fdc32ca802c404e64298b661193e01738e6548bf72b6d0865a072d3a" => :el_capitan
    sha256 "97767ede1c70e39e7f47532dcb4bd4f7907b3eb52d81854664fa2da137ae7c9b" => :yosemite
    sha256 "7219c6e30a3da536890ead980c98083b562899e4df9599d65d3167e0dcddca1e" => :mojave
    sha256 "a8aeb344f7d31cfb0a33d43389f263d8f50e702ae83c4160c08407b08bc9a121" => :linux_x86_64
  end
end
