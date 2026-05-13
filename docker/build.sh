#!/usr/bin/env bash
# NOTE: This script must be run by @janhoy (Docker Hub push access to cominvent/renovate required).
# After building and pushing, update renovate-version in .github/workflows/renovate.yml and
# renovate-9x.yml to match the new tag.
set -euo pipefail

TAG="43.170.18-full"
PUSH=false

usage() {
  echo "Usage: $0 [--tag <tag>] [--push]"
  echo "  --tag <tag>   Renovate image tag to base on (default: ${TAG})"
  echo "  --push        Build multi-platform (amd64+arm64) and push to Docker Hub"
  echo ""
  echo "Without --push, builds locally for the host architecture."
  echo "Image is tagged as cominvent/renovate:<tag>"
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --tag)
      TAG="$2"
      shift 2
      ;;
    --push)
      PUSH=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

IMAGE="cominvent/renovate:${TAG}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Building ${IMAGE} (push=${PUSH})"

if [ "${PUSH}" = true ]; then
  docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --build-arg RENOVATE_VERSION="${TAG}" \
    --tag "${IMAGE}" \
    --push \
    "${SCRIPT_DIR}"
else
  docker build \
    --build-arg RENOVATE_VERSION="${TAG}" \
    --tag "${IMAGE}" \
    "${SCRIPT_DIR}"
fi

echo ""
echo "Image: ${IMAGE}"
