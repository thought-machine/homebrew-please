class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.0"
    cellar :any_skip_relocation
    sha256 "182482ed3f86436552b10ac6d9f22f23a8a020a5114e45546df0e446e695e434" => :el_capitan
    sha256 "f366e8d78c56ac9a2ee12bbaec087cf827c459709b67fb5c8960ff696e1dbccc" => :yosemite
    sha256 "7b1a57cee6b9e89dbf88aa850b2888ad571bbe0e5594b48578511c305315d343" => :mojave
    sha256 "b345620d87e0dc8e14c8f45e07acbb93bb21b726def3e48b4eaf6aad00d5ddb9" => :linux_x86_64
  end
end
