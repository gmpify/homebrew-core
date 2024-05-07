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

    ldflags = "-s -w -X main.version=#{version} -X main.revision=#{version.commit}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/bigquery-emulator"
  end

  test do
    assert_match "version: #{version} (#{version.commit})", shell_output("#{bin}/bigquery-emulator --version")
  end
end
