class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.3.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.3"
    cellar :any_skip_relocation
    sha256 "e783f2bae65116a212bf8ddb4f5fb2cadef9117cbf358d2ad2bd5f5327efe551" => :el_capitan
    sha256 "aef12b8364e1369563dad71b3ce809d58f62c8e0cb09c3da01f835e852c79842" => :yosemite
    sha256 "38414510b396b77a0382d47b20226610619c6458b327b5cc5db43f22069fa19f" => :mojave
    sha256 "18a19bc44c4104d961df10a4b24743dfc5e7705750fcfbccf8fafafe675d9cc1" => :linux_x86_64
  end
end
