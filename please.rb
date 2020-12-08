class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.10.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.10.0"
    cellar :any_skip_relocation
    sha256 "60bf2c8c748721d5b0b61ae809544483f05f6904c9bedc051e9c56d5b2e7163f" => :el_capitan
    sha256 "aad75d335051a769b5764e6bc192a60a884fd881a75f914e8a6ecbb76096017c" => :yosemite
    sha256 "1da894e446db6343a6627370a816641467652ad8a837caa25ee2b9d053dcb5b0" => :mojave
    sha256 "a81c5dd6235d98c7f426f0c6cd3c99a14e61d920ce87c5af83e46f2640a25f64" => :linux_x86_64
  end
end
