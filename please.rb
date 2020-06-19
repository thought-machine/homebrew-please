class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.5.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.5"
    cellar :any_skip_relocation
    sha256 "28de5f5542bf67a59a21a65905645fed266e2e5547fbfdcd3e9848e7e1343648" => :el_capitan
    sha256 "bbf26b5c597d210001391b3c7f02559f7b2ca718b13e7aa52a7236b7875d28e5" => :yosemite
    sha256 "65169e9d88c0d698582f62532e64cbb9c0bee279f98fd181b15bfabae9eaa17e" => :mojave
    sha256 "0fee7d786ae07c695d72b45b34fe14e39aff017c49682ca66a08662d24f6305b" => :linux_x86_64
  end
end
