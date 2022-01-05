# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.18.0.tar.gz"
  sha256 "747c62ea8e71f9d1bf39848f608b6a6dd109f8e8ebe62341e9e9b55058c1c8f5"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.18.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "0baa0f3e4217e6c3713176ce61ee9e2eb0a18718720807005bf0cb8bd275dc63"
    sha256 cellar: :any_skip_relocation, yosemite: "99fc9bd760e3f7a3fbecdc2fa7f21eb5443f0329fa79a800e5dadf0dc656e887"
    sha256 cellar: :any_skip_relocation, mojave: "3b0369955fa42329adde611672c6536c4a5f1769c6d1e94261aebed10edcf11b"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "27c5fae0b9950523853eb907bf0adbc23612771a468c6dba089141d090d82c48"
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
