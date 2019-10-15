class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.7.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.7"
    cellar :any_skip_relocation
    sha256 "506e97a5d23b12dadf6ec8adf58c46d518a4797c7411b8b12f27f586797fd711" => :el_capitan
    sha256 "9f74910ef16e539f9e744e409f2064113ec7a638b84ddc7783349116a7226ed8" => :yosemite
    sha256 "796a51ab175f438b8d846fc8d481ae53d87305186bc5765c799cf59c84219d5c" => :mojave
    sha256 "c5b708769a9b99f83c44f40b818ad4f40d3c24b3476b2cf18f104d1efbe536cc" => :linux_x86_64
  end
end
