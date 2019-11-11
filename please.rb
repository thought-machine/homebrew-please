class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.1.9.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.1.9"
    cellar :any_skip_relocation
    sha256 "2e39e45ca5f84cfcd5fe5f91ce35a582f4b9ddd3d0889b90b825427145b5a9d4" => :el_capitan
    sha256 "733181acff733cac3e5a40f499e37da8042f49b19019ee2d9f2ae2a23915064c" => :yosemite
    sha256 "791e15a12a1ed1648e79f50088782a381fbf3ca6ff8e1dad496cf8239b1cbcd9" => :mojave
    sha256 "b1342a061a41750d6d28fbc32b1d147efb155e58197fcdc699076f3e9e75e7cd" => :linux_x86_64
  end
end
