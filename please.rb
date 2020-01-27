class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.1"
    cellar :any_skip_relocation
    sha256 "673460d9059a35321e0e6dc381ce957b0830bcb0a7b65b722dc54c4dc161c896" => :el_capitan
    sha256 "4f56dc5875463e8aca60b219521f62d474047a200042309d602979ea39396716" => :yosemite
    sha256 "2cbdb278c5890624e5c58cc2f9e1913ea4475fd852f4059dfcd27fbccc1912a3" => :mojave
    sha256 "46c446f4e40bfe31dffa2ed8818890712ac2f6d7e80486b7c29d17f527a3ea19" => :linux_x86_64
  end
end
