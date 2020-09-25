class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.5.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.5.0"
    cellar :any_skip_relocation
    sha256 "31aa6b4a01836db7712bc3859a4ca30fc4774577adb29e1460c93c8579633374" => :el_capitan
    sha256 "b15cb23d294a2e3632c1ad14663c84626d8e7e93bf4504202a7f117386aba7e4" => :yosemite
    sha256 "98771fd3a26b5e143fecb6af05035768cb59af9cbabc7f932679d5e2d6c1a12f" => :mojave
    sha256 "85f51dd1de08d2458a89d36dcf749df8c577963179d62686371ada18498c6ca0" => :linux_x86_64
  end
end
