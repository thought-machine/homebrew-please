# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.16.0.tar.gz"
  sha256 "f70c724eb3cad23417fdc840362b5e5a030aa204044de035bae24e543dc56441"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.16.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "7d9eef87776a3b39c07e68e29fb7b8aa3d8ed16bda52bd5f57e418a56750f5b2"
    sha256 cellar: :any_skip_relocation, yosemite: "bf94e4f7729fa1dfa487eabc1e658242b83c365ba47cee05371c650f10838648"
    sha256 cellar: :any_skip_relocation, mojave: "12aa43cd62171ec507cb1ed906df7e2b3a3a36147fb988d8e6b18b746cb486a1"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "486058c455030359c052a4d96074d16e8b051f012bdb60cff455d00100f122dc"
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
