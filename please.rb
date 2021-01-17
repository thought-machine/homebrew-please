class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.12.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.12.0"
    cellar :any_skip_relocation
    sha256 "bbf13ec8ba47a73ed6e10b5001957b729e52156f1dc843e6fceaa1b9a1b5dff6" => :el_capitan
    sha256 "1b2040c2694b4d145e0196e211521402af7ff61ccb1226aeed865dff7b04af93" => :yosemite
    sha256 "b878a4f993706c43e6f7e59f7ef1a9861468a1a76b21fb0c83321f8fa475a6a9" => :mojave
    sha256 "64bcfc8e7256ecba1facf7a33527ea20f172032096bef96bbac92d16437fd9d4" => :linux_x86_64
  end
end
