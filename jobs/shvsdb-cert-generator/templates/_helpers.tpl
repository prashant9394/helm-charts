{{/*
Expand the name of the chart.
*/}}
{{- define "shvsdb-cert-generator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "shvsdb-cert-generator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "shvsdb-cert-generator.labels" -}}
helm.sh/chart: {{ include "shvsdb-cert-generator.chart" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/name: {{ include "shvsdb-cert-generator.name" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "shvsdb-cert-generator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "shvsdb-cert-generator.name" . }}
{{- end }}