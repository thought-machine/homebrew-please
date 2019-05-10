class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.6.3.tar.gz"
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
    sha256 "8033209e615f8cbd57813bc9e5ff9aa2ced385d3e546769be4dab400ca437acd" => :el_capitan
    sha256 "d5a6e7a99607ee03bcdc53f830fa04e50c541061b1486936e6e5198b17759829" => :yosemite
    sha256 "c404d9398dea1265e621abbab83bcedcd12bbc842c8c60e6acb5572f9c79f5ff" => :mojave
    sha256 "229426358a4b74a9af6bdaf4aa53d974f9258f141780911257d934d7f77c2507" => :linux_x86_64
  end
end
