class BigqueryEmulator < Formula
  desc "Emulate a GCP BigQuery server on your local machine"
  homepage "https://github.com/goccy/bigquery-emulator"
  url "https://github.com/goccy/bigquery-emulator.git",
    tag:      "v0.6.1",
    revision: "316038b8dd3f6534a87948f28ac54c41dc6afc21"
  license "MIT"
  head "https://github.com/goccy/bigquery-emulator.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    ENV.cxx11

    static_link_flags = '-linkmode external -extldflags "-static"' if OS.linux?

    ldflags = "-s -w -X main.version=#{version} -X main.revision=#{revision} #{static_link_flags}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/bigquery-emulator"
  end

  test do
    assert_match "version: #{version} (#{revision})", shell_output("#{bin}/bigquery-emulator --version")
  end
end
