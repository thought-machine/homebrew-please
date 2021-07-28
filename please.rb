class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.3.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.3.0"
    cellar :any_skip_relocation
    sha256 "d1d7e65b5285840c8786fc4332d6ad4f2aaca781b959adee9bf64fde6cd2afb9" => :el_capitan
    sha256 "5fb1d5c60eeb2b781eeb394a45290ba6bc6821e3a811393a6467cb59a5b8192d" => :yosemite
    sha256 "201e6445755e88b5695c0e921deedc78d468717b1e89701ac3c20baff89418c8" => :mojave
    sha256 "a1a9b3b1368b1624dc258eb61234afcdff1bfde2e27a931970eff965fa9f4f2f" => :linux_x86_64
  end
end
