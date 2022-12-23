# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.26.0.tar.gz"
  sha256 "0bff673002de524956271b52ab2e1a9b25ead10f7668744fa65361bae6701f67"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.26.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "d4ee2d8356268392640f591592ee6ec0f7713b7f6a085f26a0a179928118f62f"
    sha256 cellar: :any_skip_relocation, yosemite: "5d3a00360525376b45cd77f7d018b34a274fc1de841550a59c3dfb042827fa10"
    sha256 cellar: :any_skip_relocation, mojave: "85ca98adfc4debb86eb28827003b398eb91360fd1ebc326b235d43c35ff0c408"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "34f2f9db6dbc4e0a9a368e11d0021abfc5d9c2e67fe4922cbd53bf9718817d24"
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
