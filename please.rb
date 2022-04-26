# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.20.0.tar.gz"
  sha256 "8997c19d43bb0bfe2f2716fc99c274785078f4c6c2aaf6911ad9295d30d93b82"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.20.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "3eb001ed5a3ccfc56e847b3a2fa3c54cd809881dfffd2b55ef85737c3132b28e"
    sha256 cellar: :any_skip_relocation, yosemite: "b889c65a24c16c37b1410b78fd9de45ca3ba425e8bdd5a166e07d2ad7c970aca"
    sha256 cellar: :any_skip_relocation, mojave: "c35735c64e57effc7cf3bcf4cea93778c7c81657e55ce14b792429a5bbae6ccf"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "36ef42df76e4821d55a8dfcd348763cce9029021f674fb7ba56ba8009992b2ae"
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
