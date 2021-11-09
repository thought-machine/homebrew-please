# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.13.0.tar.gz"
  sha256 "6953ed196d8871ce977ff5649a6ebf40371bd699f09204560e8083ae140babf1"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.13.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "8a0711deb8f8896fc17f31e38a1baa6bb098c07d5db407dee2b57b5f81c20adf"
    sha256 cellar: :any_skip_relocation, yosemite: "13b0e7b02db10ac45774c78288326e31f461006eb106647072883e6e32ca69b9"
    sha256 cellar: :any_skip_relocation, mojave: "a581c76d797c324677730511c6ad6cc0105bb65d14b35051098eecb20eca462d"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "872945f7bb566e0aec08fa075366d393653c2556ff867c8fbe7545e376bdd2a1"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/gen/package/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
