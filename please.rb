# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.19.0.tar.gz"
  sha256 "4726189af3539bab400d57b46f6b72cc2db1bcdb44c513d2b68968c9e5249ae6"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.19.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "c37ae584e4185b6b776b611e26fa8d2a0a1689e3ec09493ce0df6e770cbfbb4f"
    sha256 cellar: :any_skip_relocation, yosemite: "e29264274f148a711e0ac16f29872249c4533a2acfb79c5bd5e9795ce0f95091"
    sha256 cellar: :any_skip_relocation, mojave: "f6712a75d46839085b500546b5dcf4ffc42ffe996b1ef2fff97d6827874a99da"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "79972e6edc17e247f93de1395d4f567a99c5df9477ad914ede2db6f1eb0d4def"
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
