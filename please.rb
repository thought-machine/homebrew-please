# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.23.1.tar.gz"
  sha256 "362177416915471eeaac541d6b924cab76982bdbb48d4bce107d16186dfae67f"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.23.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "46552b052d633cdfd46d6037ea6864f7778055edb12a7869a338c9b842a3f731"
    sha256 cellar: :any_skip_relocation, yosemite: "de508abc36779170ac49e735c967c42141554b3253759d640da34b8381c4cf58"
    sha256 cellar: :any_skip_relocation, mojave: "db5d584e678425287739cf838b52c709aa49b62a89bf99f3dc95e3b8638c044e"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "f7e2f5f79657fd59fb4eaa9e620d49ddcbc88deabe4e429eccee62901ba18f41"
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
