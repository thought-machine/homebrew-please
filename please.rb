class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.6.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.6.1
    cellar :any_skip_relocation
    sha256 "5c07893b8aa77d810f009fcf077b09ae97a5ba0acfd9e966fe8dd915696a239a" => :el_capitan
    sha256 "6b6d623f4799a581bfb3a7044be3f9e325fd61cd680dc1717a69e92fe8d51494" => :yosemite
    sha256 "03a872c3b069666938e1233bbe380c4ad6974e06bfb6d06ae5c9334631b725db" => :mojave
    sha256 "8e18ae157b4a4bee2efc70443330c79dff0b37c12ec521c3f6386094fe340ba3" => :linux_x86_64
  end
end
