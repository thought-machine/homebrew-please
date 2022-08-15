# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.22.0.tar.gz"
  sha256 "8a452665995c578d82f94cdd696592b630b0dccc8fabc1ea344e5962c6535469"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.22.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "6c7a1c798aacdd2a2c7c6d9856694b1c6ce518c7853c71102bcdbf6c4a78c6e7"
    sha256 cellar: :any_skip_relocation, yosemite: "5ca0755c865652a5ace5eb04308a4cd02d19caf3396b5cd9ca82eecf7c16c21f"
    sha256 cellar: :any_skip_relocation, mojave: "3c5174a2b47fa7dd9903e5db3dd93b83056f4e3fa71a50fcb3de7d429ca92e2b"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "5bf5747cf1a0be64d60b6edb7fd64d1372bdd8ee19e5dda9709326646ba0d295"
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
