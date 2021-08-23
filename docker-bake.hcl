target "docker-metadata-action" {}

target "build" {
  inherits   = ["docker-metadata-action"]
  context    = "./"
  dockerfile = "Dockerfile"
  cache-from = ["type=registry,ref=ghcr.io/frezbo/builder-cache:docker-actions-test"]
  cache-to   = ["type=registry,ref=ghcr.io/frezbo/builder-cache:docker-actions-test,mode=max"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v6",
    "linux/arm/v7"
  ]
}
