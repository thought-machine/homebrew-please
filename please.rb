class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.7.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.7.0"
    cellar :any_skip_relocation
    sha256 "9cc51d716b5d4baa5e797232071a27eaed0267b0e5e1144c93ddf32cb500adc3" => :el_capitan
    sha256 "d3749d9e8dfa1a63de29779af1781a578899b500ebddb29daca75c1861ff16bd" => :yosemite
    sha256 "4235d1c2eafaab92303d24f2c6d9a4a5ca8ec5f90154583d51dd50229744d38d" => :mojave
    sha256 "c41bebb37028361b8fef5826b74f67a8c7259d72b354e91b1af1bc71e80bba1d" => :linux_x86_64
  end
end
