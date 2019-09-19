class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.4.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.4"
    cellar :any_skip_relocation
    sha256 "5edeab4039e65a0c82a0c18b50f240b606655e196c4822c8306f44c38fddfe03" => :el_capitan
    sha256 "163ca8f047cde2d1ea9620177595397f3e90e3dd1a2d44e7a51f09ba515cb36d" => :yosemite
    sha256 "e8db06eb3373c970bf0ee72e3c448b3ef0a66a97fb0a2a923fc2a4410fb2c507" => :mojave
    sha256 "47346fd4360d8bad3739b37b9592be3b432db3cc086e453df82ebea60f6668cf" => :linux_x86_64
  end
end
