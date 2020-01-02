class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.2.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.2.0"
    cellar :any_skip_relocation
    sha256 "6171b5f940b382eba8737da29a60e2691c3f20706f38eac85fae613edf50f569" => :el_capitan
    sha256 "cabe8e6a7b9ba1939c97a6f44e4eea3f0f1e98d0b3b49a08264d6304056ec0af" => :yosemite
    sha256 "43a801555aa4f80f19849eb890c591fbbd0c967e063ee91995b7b0a1005894a4" => :mojave
    sha256 "d9f5550bd1dd83dd4d6d810a0c537b575ecd2ecb0fbd10d6ae761fa5889cb1c8" => :linux_x86_64
  end
end
