class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.16.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.16.0"
    cellar :any_skip_relocation
    sha256 "dd8f5541fe0782b5fe916946d0e2e71c304f1919b5cec96131969d1824473bb5" => :el_capitan
    sha256 "f2f99545a86b0d1098b2ba7e97fc3203a89488abc40d52df7cacde0c6114031a" => :yosemite
    sha256 "1bd4d8105348cc172df75b391462092e5066142d63fcf82c87aaeccb84391632" => :mojave
    sha256 "7f75713424e4ad322984028098cede85b8b061f32f57d3cf7e04d2619e94560e" => :linux_x86_64
  end
end
