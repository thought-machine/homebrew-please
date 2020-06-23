class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.7.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.7"
    cellar :any_skip_relocation
    sha256 "593ad8dd2807c7c98d3bfaeb1f5b531b9ceea3bb41eb7d5c4830f2cbecf70214" => :el_capitan
    sha256 "254c781778253216a18ad821363ca5a2340edc4dcc4110a8db27a5546460a656" => :yosemite
    sha256 "f422a71e7c12b6a9981197ef2ef8f8c661fe928fc18428284f41a2d811a8587a" => :mojave
    sha256 "f5764d8c39bc50c32d945dd6d5852055dc825954d52a4682c49f68a3e79f919b" => :linux_x86_64
  end
end
