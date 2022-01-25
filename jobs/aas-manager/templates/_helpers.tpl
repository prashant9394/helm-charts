{{/*
Expand the name of the chart.
*/}}
{{- define "aas-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aas-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "aas-manager.labels" -}}
helm.sh/chart: {{ include "aas-manager.chart" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/name: {{ include "aas-manager.name" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "aas-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aas-manager.name" . }}
{{- end }}