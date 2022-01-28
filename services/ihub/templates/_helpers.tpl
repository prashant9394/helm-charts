{{/*
Common labels for ISECL CONTROLLER
*/}}
{{- define "iseclController-init.labels" -}}
helm.sh/chart: {{ .Values.dependentServices.iseclController }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/name: {{ .Values.dependentServices.iseclController }}-init
{{- end }}

{{/*
Selector labels for ISECL CONTROLLER
*/}}
{{- define "iseclController-init.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.dependentServices.iseclController }}-init
{{- end }}