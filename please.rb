class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v15.8.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v15.8.0"
    cellar :any_skip_relocation
    sha256 "3e36d3448ccba31cebf5478a7ae3e5b5328ba8bd30b5ddfa563409052a02d0f8" => :el_capitan
    sha256 "03c4e17ffed522770b5cadf71590d9785c514c0bbfd7bf8365d73fbd28345199" => :yosemite
    sha256 "d42d8ea177f15c43269cb52e7292b887d21d0d17539e759a7416d4c83361b9ac" => :mojave
    sha256 "46fc7bdcf4f3142a8b8521eeeaadc6f1f94d71debbd3e23ed3d573dfc65f0698" => :linux_x86_64
  end
end
