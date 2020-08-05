class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.0.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.0.1"
    cellar :any_skip_relocation
    sha256 "e99878d09b397cb1be0f00b8181c67fcc428cb79f494b971b115b2d8cea6fc21" => :el_capitan
    sha256 "abca3d321614b40450e7e91b5b9eff636696f8b265012f889a1fec4b56aa7f59" => :yosemite
    sha256 "5f19ecaac3e1c9ad23fc6a9e31bba5c2ad3bad3dac3271f66c7d861470ca41f9" => :mojave
    sha256 "5883674c59f26229578c09b4adf684a8ba706a39e1d6f63e4fcec4d416f26118" => :linux_x86_64
  end
end
