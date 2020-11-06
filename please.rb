class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.8.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.8.1"
    cellar :any_skip_relocation
    sha256 "427963ca670e7c3c7c165c3afc1d7e808a0e4e1592433a7c4602a351ada14978" => :el_capitan
    sha256 "00fc59fb6abb03ba7bd6e0e4cb41253dcbbd73750f1acd6c32c04b7eccb4e636" => :yosemite
    sha256 "2d4bee01959e409728e62ea0d9f08d829022cb807f2275ef0f5376b0a10ade99" => :mojave
    sha256 "ff3dcb6ca0ff41387fc2bf7ba5d8ca7243ca845cd99aad54dd04abcd519fa50c" => :linux_x86_64
  end
end
