class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.6.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.6.1
    cellar :any_skip_relocation
    sha256 "562315dc7349d8f823222467fa64b7245e7b9f8149b00bcabbc64a447ec322bd" => :el_capitan
    sha256 "37347683811419f389906c23599eec978c4befbad6cdd9d9349eb9fef37c180e" => :yosemite
    sha256 "d2d9d4de683105c487bef04156d62c5b9fbfe4090b9c029c1113d8ddd29d3cb8" => :mojave
    sha256 "0c9d73f36819936bc597a36b94afa732ed1afe2738afb4996466c1764d8d5cc1" => :linux_x86_64
  end
end
