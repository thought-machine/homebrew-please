class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.0"
    cellar :any_skip_relocation
    sha256 "a2a654b00b5a73f75896f230f5887a15595cc0fe9b21ae08e19af22f12a28f52" => :el_capitan
    sha256 "8a6b8876df0b20ee8dbe0d768bed427c30911f14ae6724bdbbd7225202d71d2d" => :yosemite
    sha256 "2a9bf68047d34d493617a593a11de9ffb2440f8f6d15632a3fca9a191374cfe2" => :mojave
    sha256 "eb7f7e55ea5b8eb1ea5f08fa5b2ebe0edd0d2902518d658f90a20c27e4760c05" => :linux_x86_64
  end
end
