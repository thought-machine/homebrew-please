class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.6.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.6.0"
    cellar :any_skip_relocation
    sha256 "08afb36bba6e5bfd58fece1f71987e8df2e13efc44297a7081693c2f4e5d140f" => :el_capitan
    sha256 "f550e2573d50c6785a369a9ae117a68fbe563d468fa3de13bd349f2f2dd3e36d" => :yosemite
    sha256 "773559755b2cb7e70a11242689e5b1526ba87c79c8e4f12c037d59d2f7d09fd3" => :mojave
    sha256 "22d913291e08109077e9c11169be5e4e4dff0b714dd8d8641677f18a734ec5c3" => :linux_x86_64
  end
end
