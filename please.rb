# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.17.0.tar.gz"
  sha256 "d3ac633117741686a93590f76052776787aa1d30bb6790a71caf1020528164ed"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.17.0"
    sha256 cellar: :any_skip_relocation, el_capitan: "73794bbbb2369e04b4a26781894e0d51e988425f80029a51ea459d5e8dff02ca"
    sha256 cellar: :any_skip_relocation, yosemite: "568a68e37eae30ed5d7a8ad000184674849342084190f499b8fb0fda81055736"
    sha256 cellar: :any_skip_relocation, mojave: "62e12ce3a94d4e69745f7f06d32b695e14ddc479456ec0563fd8e2ecde5299b2"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "c6683f454d7bc15424a29392752300760ca23407e842f9eac1f871b6426dc424"
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
