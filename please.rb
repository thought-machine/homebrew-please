class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.11.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.11"
    cellar :any_skip_relocation
    sha256 "1b45fe1bbec3b86fa810466be6f073e49268142687e6b42cefd1f8b7604a4829" => :el_capitan
    sha256 "173c532121cd9e5b731d18e527d0b80bb6b4ab03998e118b70082be8b0e983d7" => :yosemite
    sha256 "0b5ee38361b6d8cee3a66765e7ff042dedeadefb41f3cd6725dcbe6c6f6becd5" => :mojave
    sha256 "666fd038a329bef23ad2f8e00ec89ccc15a07f48a6a5463be4eb382e88f86685" => :linux_x86_64
  end
end
