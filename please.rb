# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.27.1.tar.gz"
  sha256 "60c2ccc8f8148275fa83602e0411ce33ece20f21e7090a984369e421cb6bba6d"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.27.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "166c8a2538b15519b4b1b25599bbdeedfee3aba8884af751ae5b6343b2bf354d"
    sha256 cellar: :any_skip_relocation, yosemite: "3a595eb10864b528da961f6426adcaaef239ef93992de82ae2994c67a3911ef2"
    sha256 cellar: :any_skip_relocation, mojave: "420e5aaa0fd765d3a20bfa03ed5996d8be4912fbd24666f4dd0398b2c574eecf"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "ff2a8d557401df21a5833a0e0fe110af4ba9cc1e3ca96c41edcd96e48915b1f2"
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
