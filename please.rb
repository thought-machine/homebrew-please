class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.12.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.12"
    cellar :any_skip_relocation
    sha256 "2ebfa66e8cc9fe102de3ad37024d005cba541707a1ee8b6e89554176c815388f" => :el_capitan
    sha256 "10cf072de40185bb3e5cd8dc302fd4871ede046614e1d653b794e2816f3998fa" => :yosemite
    sha256 "0403fe9d21a3027d75e367a01d90389354c3b67fc982100e352121cde5ea701e" => :mojave
    sha256 "1fcc6e19dfbd068858277fe3d61ce4d4d811a47023e80ad078f0ec490702df42" => :linux_x86_64
  end
end
