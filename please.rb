class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.9.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.9"
    cellar :any_skip_relocation
    sha256 "a17b31f1435f03286b59ce05614ec1e1a1af5941afafdd4d322839a23dc53cef" => :el_capitan
    sha256 "7bdb02ec06c3d6a6bf932a71141f06fa3fb3484ff6ff30fdd4b84b3fe1ae1da5" => :yosemite
    sha256 "b1f427837f1f831e49e7f2975c116d3a1b47108dd0ddc2177da20a4d454c30c3" => :mojave
    sha256 "a7a6bcfc1c0de8de82d06defb61199bfb10191645f6e9d03530606ab0161bb87" => :linux_x86_64
  end
end
