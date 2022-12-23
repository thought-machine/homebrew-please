# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.26.1.tar.gz"
  sha256 "be3a154fa8f64382f4808d2b85cc0252d846eebe51b8ca29d6dcd735f4c7ae4c"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.26.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "b8f6ca563054de7b024308d3cd1d1907d001801dcfab211db22325ae37d6c396"
    sha256 cellar: :any_skip_relocation, yosemite: "85a01db6bc6eb8f525924f4479eb88a658f2187e2c2b9b16fb297e71a68f2857"
    sha256 cellar: :any_skip_relocation, mojave: "669daa5a7d8e2aa618b60681851657fcca6a45e04cbfd2f0e6c4603ef0302a80"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "e0a872fbdf2a329178366c16300d809620004fc970ec030f032d4e321244edc7"
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
