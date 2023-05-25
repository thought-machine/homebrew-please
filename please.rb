# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v17.0.0.tar.gz"
  sha256 "42d38fc8160b63cf17e70c62c69e519f2055f028be0849be842b0090c34ba132"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v17.0.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "2df96ec6649f680e0ba885c6e54efad826a15bce3ea3241a73fce9a360c69a62"
    sha256 cellar: :any_skip_relocation, yosemite: "45dbe967a61948912122f9b32319f20d3b4bd3963f728df12732235162a21a71"
    sha256 cellar: :any_skip_relocation, mojave: "6ea85b095ef8c59cd091bc4a552c407d8611ce122fbb7e520e828b342b6e022d"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "f837da2f62ce4a4d5957d2659f3be7093d263a017c3b090cf66a383a85bbc3c3"
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
