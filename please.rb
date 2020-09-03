class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.2.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.2.0"
    cellar :any_skip_relocation
    sha256 "820e4085cf01797608078145e684af9b739a18bfbbab567d20ba4cf72afa3c68" => :el_capitan
    sha256 "372b57ce7641a4187f5d5e7c34175e33c75d3aee618c392d952667bf869486c9" => :yosemite
    sha256 "2f77669b147b00aa44e2dac1d7c2983f8385b286a22270fa9ec51f7bd2679e33" => :mojave
    sha256 "9040556b0289aa0fbfe7fea31c86797a6182fe42dd09c5f737452cb855e583de" => :linux_x86_64
  end
end
