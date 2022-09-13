# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.22.1.tar.gz"
  sha256 "3982b51ba054f5c13049075b4390ec0f2e372aedf5a9f9520d28f443a18b9599"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.22.1"
    sha256 cellar: :any_skip_relocation, el_capitan: "303da0f42b7e5a5fe8d3350e4c4a714d7808fc8b49ac6fde08f17a341ca15781"
    sha256 cellar: :any_skip_relocation, yosemite: "d2f407ed6199e647b7d168bf6914de76ef3a40216bb0293a7c6dfa2c67bcea8c"
    sha256 cellar: :any_skip_relocation, mojave: "6e6f1ff820ac561bb5a50a7795db36f116fc00bb598a4d364c415a18a8cb39e9"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "f5139718494b6c34f9dc53d0e28e11450dac7c60214f1934709dc6a745f729ec"
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
