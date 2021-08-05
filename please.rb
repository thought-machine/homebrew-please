class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.4.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.4.0"
    cellar :any_skip_relocation
    sha256 "ad106c647f4623050ed2cb07ece3933bcea8de91ed7858a90e73b191947dcd80" => :el_capitan
    sha256 "523f2a9440671c1f5a4dfaeaf2e5066dc6a3cb05857c88ef7d2c8064903f20de" => :yosemite
    sha256 "501706a3dd6622e6d22613f9a7ba4e95deafffd8f3f63213f7672013d6eda279" => :mojave
    sha256 "01379554adbe453480abbd7ef610f4a515599f8bad56242b65914b408f6c0730" => :linux_x86_64
  end
end
