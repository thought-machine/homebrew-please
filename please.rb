class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v14.0.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v14.0.0"
    cellar :any_skip_relocation
    sha256 "4576e43ff4eb11777bc4931ca92ea59d8f9d002050df927805800b54ef04062f" => :el_capitan
    sha256 "c4848b7a46ca035ac02170dae39d2247a4ce6487e5fa6bdd462e0e88a753af0f" => :yosemite
    sha256 "b21e4b38f2dd30edd22e3f280a9354cc697e425b1247211fd3566f563bbce1e7" => :mojave
    sha256 "cb1a6f5b0a83a43b0ae1ca71abf218d6cb68e007842de080fb630252f97021d1" => :linux_x86_64
  end
end
