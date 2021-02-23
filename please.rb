class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.17.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.17.0"
    cellar :any_skip_relocation
    sha256 "24dc7faafbaa3a4441cad1f7f404651d626dc61149a189fed22142f8da7937cb" => :el_capitan
    sha256 "4b2199e389481b7ccf834fe092a457598ff4403180067957e4a661b5b1f34a79" => :yosemite
    sha256 "75551f972b51be9084543d923f3498ed95d04773a28739ce6f8f4fe04d6f70e1" => :mojave
    sha256 "a82a659263af1c303172301450438dcc0d505a3b4d9bda7536b1e7436a86acc7" => :linux_x86_64
  end
end
