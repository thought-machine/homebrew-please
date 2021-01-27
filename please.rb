class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.13.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.13.0"
    cellar :any_skip_relocation
    sha256 "5b38f52ce382bbe6d8c82dc55459ec788a8a9f32fa1d07d849663349ae97a1a5" => :el_capitan
    sha256 "2c3acd2b659e31e64c04bfb1e090672d7ddbdbcf4e84c9e6edf3052534f64d1d" => :yosemite
    sha256 "21c8fb890adfa37381e6f70d53560b9b70cbe56c26997c0b33a198141fe4d428" => :mojave
    sha256 "5fba4dc4ac3b922e2d53de7f151de374a67acf21e8b8e552b28aee1312bf3506" => :linux_x86_64
  end
end
