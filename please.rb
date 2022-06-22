# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.21.2.tar.gz"
  sha256 "bd79e57459304579abb57360da39b2da853339934ba8df6ddbb00611ec33aadf"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.21.2"
    sha256 cellar: :any_skip_relocation, el_capitan: "c225021cf36ca882b676ea254b5bede9fa6abc3f540b8168f8b7ac3139b01637"
    sha256 cellar: :any_skip_relocation, yosemite: "26cd77e22b7b1cbbedf2659b7332e4df9dc0dbf9f9d169e0f6899ed451e9daed"
    sha256 cellar: :any_skip_relocation, mojave: "32055c1cd31e461e5b973c69152f7fde796feedf1bd0f1282f6486945e4dc211"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "6a0a2d1c8b4f24fe12c3f4e4abaa471332055c98e05e81786d8f38f26e9dbe62"
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
