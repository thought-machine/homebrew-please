class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.2"
    cellar :any_skip_relocation
    sha256 "ca9b2b3f6308787103380790f903683cca7013b4e66f777db22da6bdfc3f2fc1" => :el_capitan
    sha256 "2250e0cc1eb524ba1422f742da220c8c15122d712a89531a89486d7434593bf1" => :yosemite
    sha256 "2cac3bf096c6fa7fb3ba6f230939eae4e4520a315bfc9c7056600eb5c831c33d" => :mojave
    sha256 "39f45bd458b001f94999ab43fe9ee2a1ad044a34e882c7e3b68575cfe1f8c4eb" => :linux_x86_64
  end
end
