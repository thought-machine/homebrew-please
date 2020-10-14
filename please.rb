class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.6.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.6.0"
    cellar :any_skip_relocation
    sha256 "5d34a2de9bb8f71e6bc998faf819c67ff3bfe17fa99de084e7e45ee1a272c6f4" => :el_capitan
    sha256 "03780cb556e746c06735cc0a4e427d828eee6088225c36a275aa0aeb879a7022" => :yosemite
    sha256 "b0e6720476e454820e5795fd7f38896d7428bcad71eed4063827244edd209b55" => :mojave
    sha256 "a44c792664491eb4f2501b0d89b3c3b8ebe0b37cc9558d41da4dffb3e952da5f" => :linux_x86_64
  end
end
