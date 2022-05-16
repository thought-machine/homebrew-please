# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.20.2.tar.gz"
  sha256 "1fee6d1fbd1af63f1737df26d9e3c3bf645e4929bad7b1b6ec67983056e079e4"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.20.2"
    sha256 cellar: :any_skip_relocation, el_capitan: "c470399fae25b50be3eadc0db42d6b1f253c2ae31c7cef01e525ea8bcc61e051"
    sha256 cellar: :any_skip_relocation, yosemite: "0bfdbaf11308a99320d9e568cd76dcb42a56e6d620f8a9f187372514f4860bf9"
    sha256 cellar: :any_skip_relocation, mojave: "d9b8ce1b323acbd16a9baa96225066d450f53a9b0e0db1b99c611741778d8d28"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "ce62e65e371b022044418ccddf227010d30d76631a78cb1e3d9d50f963996688"
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
