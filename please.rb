class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.1.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.1.1"
    cellar :any_skip_relocation
    sha256 "212c0603087aa72cc9b49e86c28b59150c834f6667ad62c082e1c0e220ab7209" => :el_capitan
    sha256 "f068a27f6e47a4db89cf9353580f252a9e4a0e4bf15498920ef5a20fbd8434b6" => :yosemite
    sha256 "42b457df08af8c81a28880021a1a0838ac078a362897b94e458f189d6cad85e5" => :mojave
    sha256 "4648678e7c398b472263c80f868377ae8c0525a61915e7ab4860f9d52c7ff2a5" => :linux_x86_64
  end
end
