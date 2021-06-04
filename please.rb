class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.1.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.1.0"
    cellar :any_skip_relocation
    sha256 "e92df97a8d7f51465d0b38bcd94cd28f240c9ae65e739b4e3c50d76262edbba3" => :el_capitan
    sha256 "290ddd09355df0aebfd646bf76eb0f84f295f6ee0afdcc03005382c23049ee41" => :yosemite
    sha256 "56b429411e1de4bb48c41afaf0db32bb7c375304dbe089184161aee64ce93b02" => :mojave
    sha256 "43aed6ac631f55215b2942a3e291fa27be2f8fb85253fdeb0f7ae32f11cd9ed7" => :linux_x86_64
  end
end
