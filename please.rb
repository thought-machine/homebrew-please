class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.7.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.7.0"
    cellar :any_skip_relocation
    sha256 "066cbc0bbba03ffb1a26f32329d4c08c14d9315be7632cbf23f10667c8a0d502" => :el_capitan
    sha256 "e6dc4b06e342619b8c050b7ca9827d304ee45b570df5f5bb087eb568cf262896" => :yosemite
    sha256 "fc4c20a6478ddcddc042d2f68d36881ea8d2b766f6154e166604269d7c19a04b" => :mojave
    sha256 "770d57029af5121edd00abfab8e8049779d037a0d7ffed40d04584a3a30d04ea" => :linux_x86_64
  end
end
