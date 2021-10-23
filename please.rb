# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.12.1.tar.gz"
  sha256 "d05d89f1f77a8ceb438a78d23edf02e0ab7a2c3516076239c0871fef18fffd3d"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.12.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "aca780ebe9718c38ed55a203820a46679a00675028ccb71da9b4105e44911d8b"
    sha256 cellar: :any_skip_relocation, yosemite: "6c8b2d330533470ce8ae51742bf1489363429f7bfd73491780b026cf8e144434"
    sha256 cellar: :any_skip_relocation, mojave: "e558a8cd9024878ec3088941a05e029231b7c441a0426885bc29a59809eb1640"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "9a33ca2f0c4acf0c591d4770a49f1da7369342185b24152976c9c45bd43c72e5"
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
