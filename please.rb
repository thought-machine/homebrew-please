class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.10.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.10"
    cellar :any_skip_relocation
    sha256 "41676bdba7dcd38c90e1af824ff5a99eac2db47d07cf11b6b6cf0874a28f8490" => :el_capitan
    sha256 "192b0fd8c96da1e2c6ff9cd6e4ae57704eb412a8439e791509b2bf1fe87cada6" => :yosemite
    sha256 "fa76a2a23ebaea27511b6934b259f68409ad497f9b369a2626b1b52fe01fb6ae" => :mojave
    sha256 "ef8fe6a83601df29393d40c8400b217c32aac93838713040aca589de0f6c8855" => :linux_x86_64
  end
end
