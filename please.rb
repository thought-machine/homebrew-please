class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.5.3.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.5.3"
    cellar :any_skip_relocation
    sha256 "1f00083bbac9921eb7e85d82bf9b54ad1ce9a2b7599c8e2ade99943f06e8b268" => :el_capitan
    sha256 "da2b15dd7ca2a57a313e0e928273f8266662ea767e11a87abf99047859d7fce5" => :yosemite
    sha256 "41d9f4a594cda7fa6310f5ae2686985b1117f4270e68338ad299440980c3a391" => :mojave
    sha256 "e68857521b83a05f209bf1ab0aa61a7c3af7426b2fbbdca8804f8c780468f1db" => :linux_x86_64
  end
end
