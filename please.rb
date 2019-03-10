class Please < Formula
  desc "High-performance extensible build system for reproducible builds."
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v13.4.8.tar.gz"
  sha256 "9d581fe6a44a902401c7f1808d33ed55564fab233cf4a64cc39ef35a5a0ad8d2"
  depends_on "go" => :build

  def install
    system "./bootstrap.sh --skip_tests"
    libexec.install Dir["plz-out/gen/package/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz init"
    system "plz build ///pleasings//go:all"
  end

  bottle do
    root_url "https://homebrew.bintray.com/bottles-please"
    cellar :any_skip_relocation
    sha256 "fc2dbe37f068b6bce11cc524b9f0a3e315276983f5f6ef1556fafa8ade2ace8c" => :mojave
  end
end
