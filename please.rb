# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.6.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.6.0"
    sha256 cellar: :any_skip_relocation, el_capitan:   "1bee420ecefeeb387ffe180ed31871cf0a041b4d3dbb894f09c343149d4c5bfc"
    sha256 cellar: :any_skip_relocation, yosemite:     "8559b3191138df25cc449173e0c19f383180c4d04576ef2821ccd4ac4b9ed180"
    sha256 cellar: :any_skip_relocation, mojave:       "c6435a30fb80b18d09873f8139e64bbc58950d5a68e7f18db2ac654e9ec3e848"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "787755c4f5ebc1695e3aaf0ed7ac86a85e3bbecdac3d0aa047626a9f3b25ef80"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/gen/package/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
