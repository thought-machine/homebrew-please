# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.21.0.tar.gz"
  sha256 "de07394e47316b5b2ead209e42582ddcc394b0e328e4a782ca7f07c2aa3898ce"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.21.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "4cf7135398a9ce77f691f823a1700cf4301821d59ad06d25d276b6b37238d401"
    sha256 cellar: :any_skip_relocation, yosemite: "475b6e7778cc19ab245ac380804a686984352d78608ab095a0b9b7f2af32ef85"
    sha256 cellar: :any_skip_relocation, mojave: "5c146efe5a8b0b23b5219a990b0054b3895e714bfa6fe2b5530db79cc49540af"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "60c2efc068a1a7706f506e10895f2ba0664636db19706162f6a6f1faf9cb14c2"
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
