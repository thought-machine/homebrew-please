class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.7.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.7"
    cellar :any_skip_relocation
    sha256 "0410135b9b28bf7da9cf6e3e0dc4a157f8636cb8fcec8e19590f79680868180b" => :el_capitan
    sha256 "57e4e935d9427e94bac46fc40c1c4ffd1acf1678507e5b285cbf7772c2f808ad" => :yosemite
    sha256 "46e7f33714eb3b1f8379ecff24bba26094209f5ae37f732bda92f6ec058b16b9" => :mojave
    sha256 "cc8e00108c7bfaac1746cd42edec350a6d46edba6915d0ca12ccea688e3d349d" => :linux_x86_64
  end
end
