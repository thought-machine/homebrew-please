class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.6.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.6"
    cellar :any_skip_relocation
    sha256 "3e8319d466edd29bd8353ea287d8c86ea5e3e384eb02f60264e190fbf0ded1ed" => :el_capitan
    sha256 "f70f329ce6c155da4921dceab272a010c0233ce97294709c8f441c3c015b3275" => :yosemite
    sha256 "8bc6d6e05f5c16acb91d468dc42db274ffe14cb23d2881250db4db6e8dd4b124" => :mojave
    sha256 "c83a5b8fd17316829b8f84d6340668ad44ad6e57066c0818396ae011fa6b0c20" => :linux_x86_64
  end
end
