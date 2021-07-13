class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.2.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.2.1"
    cellar :any_skip_relocation
    sha256 "683a22fb7ba7bd07e4a27e4abf03255156a7142d4bb4bd8e1dc9671f5007c40e" => :el_capitan
    sha256 "6ac65712f0a13e3003ee52b8397534b14e09dbdecc073aef6525b44211d63657" => :yosemite
    sha256 "ba70341798f2a98a26a64bc563297c1eebfccb03ff0822a3d54f4c97bc079a76" => :mojave
    sha256 "1f1e54b8a5a2980fe7e428a087d882a57c0ced8f89ca4e21f2d5ea721c57de59" => :linux_x86_64
  end
end
