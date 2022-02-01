{{/*
Expand the name of the chart.
*/}}
{{- define "fdsdb-cert-generator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fdsdb-cert-generator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fdsdb-cert-generator.labels" -}}
helm.sh/chart: {{ include "fdsdb-cert-generator.chart" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/name: {{ include "fdsdb-cert-generator.name" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fdsdb-cert-generator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fdsdb-cert-generator.name" . }}
{{- end }}