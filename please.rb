class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.9.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.9.2"
    cellar :any_skip_relocation
    sha256 "8c41152e730e9a0006978f5102946fc0124a347ceb500753a44757bb3ede3207" => :el_capitan
    sha256 "ce37657c310e744c498f9a5265a4b3da27a9c3063b59c2ef3c138efd1a9331cf" => :yosemite
    sha256 "006efdf4e7ec1cfba4d61cca2f7fc8106e43b8c8278a3c1684fa90f71424a21f" => :mojave
    sha256 "96d6705cd251967bbddbc8ecdfcc8761f83d73b75cc73390a5b1b6de2793ce69" => :linux_x86_64
  end
end
