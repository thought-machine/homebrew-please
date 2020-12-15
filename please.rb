class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.11.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.11.0"
    cellar :any_skip_relocation
    sha256 "42047b56616c591eb968790ea5431c3a5251c343c614be5913a500ca68225f77" => :el_capitan
    sha256 "adc6454b154e8c92af1054c0466d1b906a119ffe180144d3f2d34de39aefeea7" => :yosemite
    sha256 "47fe5e276d25e64cf9e9e6c9309f82db3354752ad342775365951ddbd744cbc7" => :mojave
    sha256 "ff419509e29842e0e4c1bc01faf6b5006e2f8474bdda7a9b5d8601fcf4fc9698" => :linux_x86_64
  end
end
