class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.3.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.3.0"
    cellar :any_skip_relocation
    sha256 "e6fcac39a485059ffbe0dd8d9b0ece4974e2023b6e587586d021047a82acb83f" => :el_capitan
    sha256 "f506df3c8918efc1c27c66c0738fb451cf93a7902321ce49eb0d3f7042c75dd0" => :yosemite
    sha256 "bff9f9574a5ee0d1a7520dfcd1d0ae8446f6d2eeaf68a527e999e7726439e732" => :mojave
    sha256 "81e088ff513d786cb0fa2f5609606ddb1bbbe672f927c5a804037629a19aab42" => :linux_x86_64
  end
end
