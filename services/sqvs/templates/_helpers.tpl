{{/*
Common labels for SQVS
*/}}
{{- define "sqvs-trusted-rootca-init.labels" -}}
helm.sh/chart: sqvs-trusted-rootca
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/name: sqvs-trusted-rootca-init
{{- end }}

{{/*
Selector labels for SQVS
*/}}
{{- define "sqvs-trusted-rootca-init.selectorLabels" -}}
app.kubernetes.io/name: sqvs-trusted-rootca-init
{{- end }}