# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.11.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.11.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "89562faa9a0b9cfc6dc12067f9d42f1e7a5f10b2019bbe3164042a79d7d2204d"
    sha256 cellar: :any_skip_relocation, yosemite: "e3727f32f58b5b75c6de8a5ad788e8415dd74ff48a685ff99ad4840fd3b257db"
    sha256 cellar: :any_skip_relocation, mojave: "0ee1e350723dc42c3bd91261be7a9986a6553df20cd9caa020431e484ba22a1d"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "f1b915ab13deb33c8638ccfdcb87e57025306dcbb41455049067effd092eca12"
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
