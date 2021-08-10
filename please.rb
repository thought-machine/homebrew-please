class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.4.2.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.4.2"
    cellar :any_skip_relocation
    sha256 "92c5c45d6a896cf7dfa8ff46141b8d4ce0d80387fb636cdf9d6132ebdf5986a9" => :el_capitan
    sha256 "98db26923d2a315396af624cda763f3ff6f0827fe5d504f50ed1f905ee82a9da" => :yosemite
    sha256 "59b6cd0a53b321a7e5efaed091b45765b603aa9f6ee056913dff387669dce9cb" => :mojave
    sha256 "10719e222d108b7926ee1a892c96a3babc40275c301703d05403c69ce035b61e" => :linux_x86_64
  end
end
