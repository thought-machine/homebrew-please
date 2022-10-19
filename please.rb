# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.23.0.tar.gz"
  sha256 "f9d7e9b4726ff3353cb43fc91fa1e1001fedb307f13d70653f00a7bc1b609d54"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.23.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "c0895590bfd9da7b613196c4497fea7c29d346077b7f9f1be32d34f81ff951da"
    sha256 cellar: :any_skip_relocation, yosemite: "c5baa384ad5651fd15df0b344bb0d039773ac154dd4c47e10eb01e62d0fc1cc2"
    sha256 cellar: :any_skip_relocation, mojave: "043dfc1850ddb5d54b16f3098cef32443baee9130677a89340a8beb09458a4ba"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "e8cc729c3e53cb2cd1069c414126f6cb25eb12541d1fa7b0918e5a1c34618bfc"
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
