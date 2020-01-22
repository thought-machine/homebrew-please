class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.2.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.2.2"
    cellar :any_skip_relocation
    sha256 "3ce65898365fccfae7c495a1eda316d300a185d6728ddc451d943cc9dc06db37" => :el_capitan
    sha256 "2a1a0e22127c1b51f2f8aae292636cc22f7219beac3ffaea87816472cc4a960d" => :yosemite
    sha256 "d85396a0c7ed4e800a11a4db6080abbc3831b822727526dadae680e21c1a3a74" => :mojave
    sha256 "5f48619e6bc1b293a321da13c908210a883cdecad7820d687d7df2d36ca28a0a" => :linux_x86_64
  end
end
