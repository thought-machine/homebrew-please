class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.5.0.tar.gz"
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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.5.0"
    cellar :any_skip_relocation
    sha256 "80f47a67421bb8caa1ef07ffc462d19dbbedfdc81a7149afed4c8e3a7880c370" => :el_capitan
    sha256 "de28f2d1194bafc903f2e3ea1c7ccb651110657fb36844ccb2e3d8fba265ded8" => :yosemite
    sha256 "3093ce27667210361001bc46e324b9a166bed58da8b3a6c1171dc00c14242857" => :mojave
    sha256 "8fd16f925b52b01620e818f67131cece61b0be8512ff5489cec25cdb3f3622d8" => :linux_x86_64
  end
end
