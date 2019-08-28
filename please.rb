class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.0"
    cellar :any_skip_relocation
    sha256 "e1ee80ae36b70ccc6ca7f662ee6f8a2d91ddf2d967d1cb9da56ac1f20be5cb37" => :el_capitan
    sha256 "4c6c56a172b627c91f9e826dc4af2521dd7a41d69e99e2b9d39bbaedad08ab86" => :yosemite
    sha256 "cec17479c8b68f127a4e1bf1c1b4f552957ac4bcadd0c166cc23e341e54ffdc7" => :mojave
    sha256 "a2614172a51aa807a2aa045a2983db08cc487d1ffb3cc9adc5b2b136b2ca75ac" => :linux_x86_64
  end
end
