class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.8.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.8.0"
    cellar :any_skip_relocation
    sha256 "fd3b2ecefcdaaa8d463564cc2b697ddff324e1e19bb903a22288b34cb3979c11" => :el_capitan
    sha256 "323a18660e87dda50d68b90bfd973a3295d90307e063ab8402f13b400451c9e1" => :yosemite
    sha256 "99a8e35c3bcb0920c5e6ada3ce3331595be5e0cba3ecf9cfd7cf5caa22ebd8ed" => :mojave
    sha256 "730a0641affb49cb2aa2ddb8be5ba9f6929b83f7525c2fb02e9e02958511e731" => :linux_x86_64
  end
end
