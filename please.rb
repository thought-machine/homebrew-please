class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.9.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.9.1"
    cellar :any_skip_relocation
    sha256 "ed4c7d788305100b7cfc2ec5570ac00ad85568a5b2250520facf7aacd8874aca" => :el_capitan
    sha256 "b7c56164c4596af583f4e17f8df5ff8891620770f754e7bf7cf6a2ed78a50eff" => :yosemite
    sha256 "a1402b5ccb78afad7041b0c6a9e7358041a1349fa42cde59835a01efa2302557" => :mojave
    sha256 "fca8cbb12a9bf28fb0f639d97c0b7b5bc5582dd6039a4a505a9fa92cd301701b" => :linux_x86_64
  end
end
