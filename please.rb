class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.9.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.9.0"
    cellar :any_skip_relocation
    sha256 "fa02845cc54a87dfe40fefe46c87f8767e7acaac8fb3656884a026cb63acff83" => :el_capitan
    sha256 "2b83b9832f156ffd1e91bd3ca2733f0c4ea5825b3671ca1766248a2d0d64050f" => :yosemite
    sha256 "d159fdb028f32e961393602d5072b330a5cfbd1a947d9be5bf68cc30c995a3b9" => :mojave
    sha256 "1ec206759cc43b9d71e19569deedb6fc5d06da2741984372cc95aff1b815d30d" => :linux_x86_64
  end
end
