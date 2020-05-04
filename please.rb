class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.4.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.4.1"
    cellar :any_skip_relocation
    sha256 "148377822c8b3bcc268c6f2aa4993b650e4b7049de25ce14d4dfc93c63d91be5" => :el_capitan
    sha256 "507cfe77b7ec16606ee0da84d9e7c8ee4102aa1473fb83f53b93ff60ce979f9f" => :yosemite
    sha256 "1a727ac1a53bedeecd7d3e54fc13bd02ce96996f07e57c9bbefef9577069ad93" => :mojave
    sha256 "ebac323e486e32b5cc6e801a768615bfa8bc59eec60bcec1decb31bb4f9dfeb1" => :linux_x86_64
  end
end
