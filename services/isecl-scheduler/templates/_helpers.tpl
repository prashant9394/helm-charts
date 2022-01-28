{{/*
Common labels for IHUB
*/}}
{{- define "ihub-init.labels" -}}
helm.sh/chart: {{ .Values.dependentServices.ihub }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/name: {{ .Values.dependentServices.ihub }}-init
{{- end }}

{{/*
Selector labels for IHUB
*/}}
{{- define "ihub-init.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.dependentServices.ihub }}-init
{{- end }}
