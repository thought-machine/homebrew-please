class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.1"
    cellar :any_skip_relocation
    sha256 "cb0df5dee8076096514ca16ada2575d04fecb67363028c1421556d20f062239e" => :el_capitan
    sha256 "bf80ece157d398d1df1fdaa86ce743da9a4a0d02e1e26eef2dbac02095b3cdbd" => :yosemite
    sha256 "0c0d262d5c0a772b7a5fe726249fb62d6e397794c1302aa486bdb5c06158142f" => :mojave
    sha256 "adf6e0488c854d0d1bb956b70de26460e711292f3d5839b1d76f78bb8fb26561" => :linux_x86_64
  end
end
