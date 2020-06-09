class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.2"
    cellar :any_skip_relocation
    sha256 "56347680be2b1628b8b676c770ac1bb6a304c0132afa8198e6fffb8f211061b9" => :el_capitan
    sha256 "cae080ac0349e27b92dd52c3af7a41a8a858398ee36b26b3a4a65e85e532ba41" => :yosemite
    sha256 "59e8f4179a30c0a95dd4b61dc3ee16f86199dd12a6dd49f8e38a8388ade7d14d" => :mojave
    sha256 "ba092ce263f27fdd1a75ef7421beb6e6ac8e3d38638751cadf4de312b103c908" => :linux_x86_64
  end
end
