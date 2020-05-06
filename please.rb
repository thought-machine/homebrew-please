class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.4.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.4.2"
    cellar :any_skip_relocation
    sha256 "e0232ebcd4d662143384b6af97e29916eff7cbc67a4b9dd6a04d9645249fa06a" => :el_capitan
    sha256 "78ed6f0af00a030ad127f1573ce6893f58ff4c9235fb8538db41f4e071e7e5e4" => :yosemite
    sha256 "5f5c32397d83de714431b98f79050f73978753848ec7bb0309b876650ab8c3ee" => :mojave
    sha256 "9a2c4eed05584aa7e8857afcc0cb33119b0600f43672a59c5f1bd24a6c8205f3" => :linux_x86_64
  end
end
