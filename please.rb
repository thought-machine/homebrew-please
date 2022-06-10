# typed: false
# frozen_string_literal: true

# Homebrew formula for Please
class Please < Formula
  desc "High-performance extensible build system for reproducible builds"
  homepage "https://please.build"
  url "https://github.com/thought-machine/please/archive/v16.20.4.tar.gz"
  sha256 "87e1503185ff2e0634eaa62f825f46ae3cd860c3834e30706e0eb44e8b48f604"
  bottle do
    root_url "https://github.com/thought-machine/homebrew-please/releases/download/v16.20.4"
    sha256 cellar: :any_skip_relocation, el_capitan: "dcd93499256c3f3edd420c41314ebec00c32114140dbc20c7190579ada8b5719"
    sha256 cellar: :any_skip_relocation, yosemite: "7ff153650a1694d7a121189f1b89490a5c21584de052b6fda6ca050aa06582d1"
    sha256 cellar: :any_skip_relocation, mojave: "1984def0fc234de97405028c8ee74ca91b4696b892762deaafb871dd654e2708"
    sha256 cellar: :any_skip_relocation, linux_x86_64: "2ec24af1f7af4ff853a3f08ca438635a9b1fa99bbea164318c6947cc06050f43"
  end

  depends_on "go" => :build

  def install
    system "./bootstrap.sh", "--skip_tests"
    libexec.install Dir["plz-out/bin/src/*"]
    bin.install_symlink libexec/"please"
  end

  test do
    system "plz", "init"
    system "plz", "build", "///pleasings//go:all"
  end
end
