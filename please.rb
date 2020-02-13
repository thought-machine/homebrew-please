class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.3.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.3"
    cellar :any_skip_relocation
    sha256 "bf84a4074dd8883772f08a3b67ced1d4822169fdf35b7126a68e20b85c6bcfad" => :el_capitan
    sha256 "53d57c37aff0cc15d70b3c4a3771a1d04b70ede618f59ceeac468623e16d84ca" => :yosemite
    sha256 "204fdd5893e7c66a8e779e7f25869e4006b7de7ff52a3a54b2d94f452b8b1f6b" => :mojave
    sha256 "b99aeefbfa251b165eedc9c09fcac8b1f1c523bd672e2087e2a0263b9a42e976" => :linux_x86_64
  end
end
