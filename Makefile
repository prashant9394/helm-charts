SHELL := /bin/bash
APPNAME := isecl
REPO := amr-registry.caas.intel.com/isecl
VERSION := v5.0.0

# To push files to harbor
push:
	VERSION=${VERSION} ./.github/workflows/push-helm-charts.sh
