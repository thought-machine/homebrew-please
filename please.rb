class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.0.1.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.0.1"
    sha256 cellar: :any_skip_relocation, el_capitan:   "968a4f565a14bc2961af65a0e026f25727e9fa7d53da523941d24bb7eb16cb00"
    sha256 cellar: :any_skip_relocation, yosemite:     "55d39203a200dd19ce7590ef01cd3bac575c2664f6ae7a8dec7f9b642fa5bb75"
    sha256 cellar: :any_skip_relocation, mojave:       "4ae5c6b77e435c008c26320726952b6bd42bb0e1356d1e44eace07e741b68607"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "1a8c1a37ab81f9ba409a4c8dc7103b98a1194b20b321e586de42fe16d8ebd488"
  end

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
end
