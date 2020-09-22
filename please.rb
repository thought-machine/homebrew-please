class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.4.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.4.1"
    cellar :any_skip_relocation
    sha256 "885e15e8170661019eb79b2c1bb16bb13b53275eba9583df3ffbcde854666af2" => :el_capitan
    sha256 "bfdccd039c3ddce11bb46dfc40e296b2d6b283efd6fa76d37dde911329be525c" => :yosemite
    sha256 "7c08c2cd7acd45c1b96f8a5968a9918f99ca9568c275b0f8f9340d1eb8b8ed4e" => :mojave
    sha256 "72a962be58b1dc62869d4dd861f93f23ff0ae22e81797cb7fce0e29c199ca176" => :linux_x86_64
  end
end
