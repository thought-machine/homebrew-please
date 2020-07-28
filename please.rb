class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.0.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.0.0"
    cellar :any_skip_relocation
    sha256 "7fda15358baa3f5ea21e561809475612e6e9d56229380f47a2ee5c082e19c42c" => :el_capitan
    sha256 "c73fe61ad9b8f6e24dbf52692256cc5cba574a4c016f1542a41e40a3306b7d0f" => :yosemite
    sha256 "23e40d01cfb0ed1ee86085cf8ac3bcf57455487b0f6d480bd116367926b8433d" => :mojave
    sha256 "338ceaa775e2491a954a6d54526416729483d4f2aa0860454defe5102bb2b343" => :linux_x86_64
  end
end
