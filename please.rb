# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.15.1.tar.gz"
  sha256 "2173d961930e71f6fe517cd23bdbc9554eef66d41489a146ee289f84c78d791e"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.15.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "1a3287877f4713bc8bd7f6645bf9bbd87dbc804f87346cbc788ba50e316125c9"
    sha256 cellar: :any_skip_relocation, yosemite: "a3137bbd5722b3a62d5de4000b52ce83f8971ea8775462dafd48a444bffe7b5e"
    sha256 cellar: :any_skip_relocation, mojave: "c6ff615bebbfc234c742d53af0088e20dab998e5ed25644940c70c6966bc9225"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "f692d3659ca2ed007e6b9f287eb5263a685f6a56410ad860e1fad2b8294a30bc"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/bin/package/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
