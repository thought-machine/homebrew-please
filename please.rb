class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.2.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.2.0"
    cellar :any_skip_relocation
    sha256 "f1da87c3df8133a712928d18966ed0d408c9da61b4df5d4f54818bdddb934e8a" => :el_capitan
    sha256 "190ec39b07e1bc1b150d05f442656864883ebad187cb16cd84a9e1a2f5bbb4ac" => :yosemite
    sha256 "aeeff4e861498288beefc32e7f14c07e6f32e549243b43358faf6682a45674de" => :mojave
    sha256 "cef9829e507da74fdc27d8ed626532576176edcd4dfe3460d1ed12bce0acb2cb" => :linux_x86_64
  end
end
