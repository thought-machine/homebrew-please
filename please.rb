# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.27.0.tar.gz"
  sha256 "d4d7fc97170fc6a2d547d9f662bdafe4c34f1811fe0627ca30c0aa309d6cfbfc"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.27.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "2217f47c643a7399adb8ef122b95321e471df1ce536180164702e31da44c00e2"
    sha256 cellar: :any_skip_relocation, yosemite: "498e6efcbfd0b92aea5a70edc439fea071f232f19be0db0804918ac5c8dbe3c6"
    sha256 cellar: :any_skip_relocation, mojave: "2b145bb912f65fde633c66654a181527c14c58eebb2ae7f07a036af76924d86b"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "2a3119aae408c61934c544a5d092c77b3a333616406f04f9f6b64b0d1f048e99"
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
