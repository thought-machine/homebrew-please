class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.4.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.4.0"
    cellar :any_skip_relocation
    sha256 "edbfba663af1f62365f4612410f3c9298ce2d877db94c30fce7b02f34e4e6ee9" => :el_capitan
    sha256 "b3cca76afa54418022fb68608fbfc16eb155abbe507ac042df4421729205129a" => :yosemite
    sha256 "42f0bf4d075dcea8a608633cfc1491509a128a15a99e193ad8185c2163f75f97" => :mojave
    sha256 "9acfb91e5c94655ee80f2dca2993bdd405b9ac163aed89fc495ab44698012cb4" => :linux_x86_64
  end
end
