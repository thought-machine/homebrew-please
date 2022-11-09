# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.24.0.tar.gz"
  sha256 "373a226fa44da64fc651a4cde750a27160d320c8d236762a95b4e04de58f2574"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.24.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "24efaeca5945fc0df11b46436f57d537427c3ab234ff6c3a2b0050c29309b880"
    sha256 cellar: :any_skip_relocation, yosemite: "093353f76d16ca8998c07f3260b4ed4966786c1b2fef8793e0cea578e29b0545"
    sha256 cellar: :any_skip_relocation, mojave: "1ea8d2568f6074aac483e1555b2577d4e7577a5489d7c6957d9f74e843f632d5"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "421c7a1a9141ef2870286db38a931cfddc27da7c87be286c4f08103b3a649f44"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests", "-p"
    bin.install "plz-out/bin/src/please" => "plz" 
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
