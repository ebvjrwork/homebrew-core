class Cidr < Formula
  desc "CLI to perform various actions on CIDR ranges"
  homepage "https://github.com/bschaatsbergen/cidr"
  url "https://github.com/bschaatsbergen/cidr/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "caee614f119ec7383bc9a9dc04a688b4b058d15106f70f523d04c8773d2fa086"
  license "MIT"
  head "https://github.com/bschaatsbergen/cidr.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b7153f1cf7540e2966261b3a69875731514f364f4f28ce3184e00d609bbd7295"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a998fc1f984187e66573e9e9de0a18b376599f644d11143f2ae8c7943304dea1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dfde83d0c88cf76c74ac93fcc8485024db460254874c15e3ff305c0153d2aacc"
    sha256 cellar: :any_skip_relocation, sonoma:         "ccd1c353b3bd3734f62dff2efc68e09594196c0425d3a34031e23dd0d61eb1ed"
    sha256 cellar: :any_skip_relocation, ventura:        "e5d865361ae84e63c3964fc5ebe51133bd771b792d3bc3fe9b4e4ee3a3674b5b"
    sha256 cellar: :any_skip_relocation, monterey:       "a61e4007cb4b4064ee348feb43d7f3ddd337659b02083a25caf4ab5082be954a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "84c00896701928e328233f04e4978dd39ae2dde83714647eeac08a1fdd4a41e8"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/bschaatsbergen/cidr/cmd.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cidr --version")
    assert_equal "65536\n", shell_output("#{bin}/cidr count 10.0.0.0/16")
    assert_equal "1\n", shell_output("#{bin}/cidr count 10.0.0.0/32")
    assert_equal "false\n", shell_output("#{bin}/cidr overlaps 10.106.147.0/24 10.106.149.0/23")
  end
end
