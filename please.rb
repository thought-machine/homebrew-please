# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.12.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.12.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "9b43c25d03e9d3da1195025f844ae06376aa29c7a651e6b22bf8f1abbaebfe16"
    sha256 cellar: :any_skip_relocation, yosemite: "ce0881102b4fc6f1ba08f13a94817270d7821aad94499897c50f9a531312040a"
    sha256 cellar: :any_skip_relocation, mojave: "8c1dd0e70f64610a1ee8e66e3e819d15aae71749c44ea92285f8ddd65d8652dd"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "31d558e66fa76a681eac391bd7f7d8c3b37bf3a13664320e0ede9ba2c3265405"
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
