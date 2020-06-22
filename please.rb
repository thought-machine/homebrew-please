class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.6.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.6"
    cellar :any_skip_relocation
    sha256 "e6cf456c390919ad4b796a00a2567b51045328a762c128e9d89f72a0794576f2" => :el_capitan
    sha256 "8fddec4f1a7ba02f3d3e944df2f8ea60ccd986a3d32af87844656cfba30acd91" => :yosemite
    sha256 "dd3bc0242827dae73d459c445ef0e7e4ac44fc88caa973720247170231f8c71e" => :mojave
    sha256 "2b6b181118917d17cf2289c89c17a840a385287c8b4468c8b75661febc034b34" => :linux_x86_64
  end
end
