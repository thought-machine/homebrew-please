class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.8.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.8"
    cellar :any_skip_relocation
    sha256 "899f17d080d988b3bd7c12c5656bc24e68071cf1f4a281a39a6fa09e7fd0f498" => :el_capitan
    sha256 "9f8d1e23a47b7f29a03faad181941a70c07288ed96dfff8caa76741abf475bf8" => :yosemite
    sha256 "6da80ab7758a1994f57a6c6c2544bd384da205ca3656c8fcd409ca91c7ec2d66" => :mojave
    sha256 "59446ada303c965d3fcdf9ef5e51d7a1cce9acff44c190076839876c9ccbb7ff" => :linux_x86_64
  end
end
