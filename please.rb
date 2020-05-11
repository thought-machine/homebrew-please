class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.4.3.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.4.3"
    cellar :any_skip_relocation
    sha256 "e77cc463444d53caaee5be953d4f0bd0895efe97bd13f5626f148523200461a7" => :el_capitan
    sha256 "98fba545a97d677902b924af9a5548735c3215067b146db2d32e1c682a1aa9c9" => :yosemite
    sha256 "ac64e38ae602217a1922ae88d29155061f7cef68e95423b238bdad1379698aad" => :mojave
    sha256 "6f2bc5fcb15045febea58fde06240b8034159ca7c5ab18706fb971e46ccf0d78" => :linux_x86_64
  end
end
