# Setup name variables for the package/tool
NAME := asset-mongo-mexpress-stack
PKG := github.com/mongodb/$(NAME)

CGO_ENABLED := 0

# Set any default go build tags.
BUILDTAGS :=

include basic.mk

.PHONY: prebuild
prebuild:
