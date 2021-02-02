class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.14.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.14.0"
    cellar :any_skip_relocation
    sha256 "0135d171abca128bd0aee3b1b510aeab100bf6ef847701c79f5137ef2c22fe57" => :el_capitan
    sha256 "3b37dd4a27369e01c53f82b0412c2a6729f5edccdbb37963252b00019445b06e" => :yosemite
    sha256 "d48e1a82f41af82105f0371fc5d0b3f2a201b74696e736ab147747f75e6e251c" => :mojave
    sha256 "76e2e1d6e69489e21c9814ae8189b83df99a580850374643f3220b1aab280a3b" => :linux_x86_64
  end
end
