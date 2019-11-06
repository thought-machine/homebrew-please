class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.8.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.8"
    cellar :any_skip_relocation
    sha256 "b5d6b9fe1ec46a4dacf74c085683d2b59d852dad0c93195aaef8048144a96c86" => :el_capitan
    sha256 "ec4e3b15acd749206cd35deebd2a1da652b3897f9acac8a918486bb3d52cffa1" => :yosemite
    sha256 "48de7a0d8c3059ee8ec2063f153f4fa6280919f64bb8d7810247d9a7a5215e08" => :mojave
    sha256 "ecfd197c1fbd40366012a18124ec0163cd4026db6a25ec6e6c4da822f70b6eae" => :linux_x86_64
  end
end
