# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.20.3.tar.gz"
  sha256 "6af16d3156420d6ab9e3c2dd98581f4261ac3fe19fe82c7b6ab9ea2560e1bfc8"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.20.3"
    sha256 cellar: :any_skip_relocation, el_capitan: "bd075edcb483aee0504f529703ff8b42455fbdf270775336e419f59420407851"
    sha256 cellar: :any_skip_relocation, yosemite: "974436ccee2c4142111b939698cd0cf17eb27614c3b302fcaee957b7476ef79c"
    sha256 cellar: :any_skip_relocation, mojave: "f74334018c545e7f458abb1d2f80fe28ed7e6f38510baa5d9c6d8abb0706a893"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "8e7a6cb16f827f5745f8c44cc769b3020d4a2e168f9db3f6471e41f906b3d080"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/bin/src/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
