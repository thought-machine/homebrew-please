class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.17.1.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.17.1"
    cellar :any_skip_relocation
    sha256 "8f01ef64e3e0251c4ff407e81449d826bbbd0e6e61f69c9b6f1370734cdcfaff" => :el_capitan
    sha256 "3feb4e2e1ed7645022aa03d2fd7d9527207561aaca9bfa720b01113eedad8dcd" => :yosemite
    sha256 "0eba534ebf7f9cea5b9eaaadadd08f69006e417d7cd36749466b8163a6c832b0" => :mojave
    sha256 "8ca9e683c1ac43d952026cba7cef576e81acdc58b25acba83aa37bf241864558" => :linux_x86_64
  end
end
