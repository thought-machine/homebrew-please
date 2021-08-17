class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.5.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.5.0"
    cellar :any_skip_relocation
    sha256 "86fbfcab1eb84031b05cee184f7c1acca5b60bbeab193f6ad6ddf56bde3928f1" => :el_capitan
    sha256 "9e31877913af761eb51061cbdd40ee46be07c6a6065ac5e597bc243850149568" => :yosemite
    sha256 "67e1088354a81b399d178ef2fcfa301bd2da25f581a3a0e77936abdb3b0336ea" => :mojave
    sha256 "e08a60af6fa93118ab7e6107a6fd2bfc9583efbb713ac1f338120c48de5ea9c1" => :linux_x86_64
  end
end
