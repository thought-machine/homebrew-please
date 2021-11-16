# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.14.0.tar.gz"
  sha256 "7696c281610b25141ab16edc9e51ac24ecec4042079b2654ada4ea6312a82c17"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.14.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "f854e9d3e5bbacee056028788242c127d26569878217b3b694e87400b7452515"
    sha256 cellar: :any_skip_relocation, yosemite: "ec646cb56338444cb54630b7fa04555ccb67baa256f15e081b913ecca302750b"
    sha256 cellar: :any_skip_relocation, mojave: "a0d518ad9ede08b3e38e9cc4716fe0240c501f2264b235cd705e382bcf7834b2"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "f80ed4d19195ea26b251c9904986117e5891c73765fd41c394e9f6647674931f"
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
