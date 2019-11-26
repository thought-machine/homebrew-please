class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.10.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.10"
    cellar :any_skip_relocation
    sha256 "cb5f0af2d01f047495e4dfee0297e215f66ba10fc24ccaea84cc8c651c100b42" => :el_capitan
    sha256 "a8f7baf77ed9d343da1f3c10ce741603b46c792e569686fb7906100b95eb881e" => :yosemite
    sha256 "4adb31555259fbec3404d7f3cce58b5c6e30a1d799db86845d8689e02c687651" => :mojave
    sha256 "cc36d50f17339a324e26f7f1a1fe58505b76b57c94c4065207696d48feaa7cf5" => :linux_x86_64
  end
end
