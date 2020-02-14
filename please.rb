class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.3.4.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.3.4"
    cellar :any_skip_relocation
    sha256 "f5be6c6f048200b8794879392260a3c6244e30b792b68c061cf491b474b58867" => :el_capitan
    sha256 "7746d29dd7ccb623ed39b2a3c45fbac7680864cde50907fd8143c48d8f753869" => :yosemite
    sha256 "be363ef14afb152a0f6d61a9e939a838d3aae5ea32c9a0bd489e44f58cd337d9" => :mojave
    sha256 "a8eb4d3c097a771531f6169c7c61f762b871da7d341b1516e7cd20eec3b10303" => :linux_x86_64
  end
end
