SHELL := /bin/bash
APPNAME := isecl
REPO := amr-registry.caas.intel.com/isecl
VERSION := v5.1.0

lint:
	./.github/workflows/lint-helm-charts.sh
# To push files to harbor
push:
	VERSION=${VERSION} ./.github/workflows/push-helm-charts.sh
