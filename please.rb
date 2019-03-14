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
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v13.4.8"
    cellar :any_skip_relocation
    sha256 "2456db20e2c6b312a2ab67432c7f3d9f611be62a31b0f28431a29f090fa33988" => :el_capitan
    sha256 "f6bd326cc6790dfd6832c2e0086251c7815d742fc8b8853b7a31be2afa75ffb6" => :yosemite
    sha256 "4f6dbc097fab5a5560edd3ddadd2a61ef203e0c8f06eb49a25344e00907e62a2" => :mojave
    sha256 "654d7ef0f8fa83b56586e0a5b906cd8ddc20dc38c2ec220c0802dc94e5a9d218" => :linux_x86_64
  end
end
