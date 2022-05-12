{{/*
Job for getting custom-token secret
*/}}
{{- define "factory.getCustomToken" -}}
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "factory.name" . }}-custom-token
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "factory.labelsChart" . | nindent 4 }}
spec:
  template:
    metadata:
      labels:
        {{- include "factory.labelsChart" . | nindent 8 }}
    spec:
      serviceAccountName: {{ include "factory.name" . }}
      securityContext:
        {{- toYaml .Values.securityContext.customTokenInit | nindent 8 }}
      restartPolicy: Never
      {{- if not (contains "Trusted-Workload-Placement-Cloud-Service-Provider" .Template.BasePath) }}
      initContainers:
        - name: {{ include "factory.name" . }}-wait-for-aas
        {{- if .Values.global }}
          image: {{ .Values.global.image.initName }}:{{.Chart.AppVersion }}
        {{- else }}
          image: {{ .Values.image.svc.initName }}:{{.Chart.AppVersion }}
        {{- end }}
          env:
            {{- if .Values.global }}
              {{- if .Values.global.proxyEnabled }}
              {{- include "factory.globalProxy" . | nindent 12 }}
              {{- end }}
            {{- end }}
            - name: URL
              value: https://{{ .Values.dependentServices.aas }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.aas.containerPort }}/aas/v1/version
            - name: VERSION
              value: {{.Chart.AppVersion }}
            - name: DEPEDENT_SERVICE_NAME
              value: {{ .Values.dependentServices.aas }}
            - name: COMPONENT
              value: {{ include "factory.name" . }}
      {{- end }}
      {{- if .Values.hostAliasEnabled }}
        {{- toYaml .Values.aliases | nindent 6 }}
      {{- end }}
      containers:
        - name: {{ include "factory.name" . }}-custom-token
          image: bitnami/kubectl:1.23
          securityContext:
            {{- toYaml .Values.securityContext.customToken | nindent 12 }}
          env:
            {{- if .Values.global }}
              {{- if .Values.global.proxyEnabled }}
              {{- include "factory.globalProxy" . | nindent 12 }}
              {{- end }}
            {{- end }}
            - name: CUSTOM_CLAIMS_CREATOR_TOKEN
              valueFrom:
                secretKeyRef:
                  name: {{ include "factory.name" . }}-custom-claims-creator-token
                  key: CUSTOM_CLAIMS_CREATOR_TOKEN
          command: ["/bin/sh", "-c"]
          args:
            - >
              echo starting &&
              CUSTOM_TOKEN=`curl --noproxy "*" -k --request POST 'https://{{.Values.dependentServices.aas}}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.aas.containerPort }}/aas/v1/custom-claims-token' --header "Authorization: Bearer $CUSTOM_CLAIMS_CREATOR_TOKEN" --header 'Content-Type: application/json' -d @/etc/secrets/custom-token.json` &&
              if [ -z "$CUSTOM_TOKEN" ]; then exit 1; fi &&
              kubectl create secret generic {{ include "factory.name" . }}-custom-token -n {{ .Release.Namespace }} --from-literal=CUSTOM_TOKEN=$CUSTOM_TOKEN
              && exit 0
          volumeMounts:
            - name: {{ include "factory.name" . }}-custom-token
              mountPath: /etc/secrets/
              readOnly: true
      volumes:
        - name: {{ include "factory.name" . }}-custom-token
          projected:
            sources:
              - secret:
                  name: {{ include "factory.name" . }}-custom-token-json
              - secret:
                  name: {{ include "factory.name" . }}-custom-claims-creator-token
{{- end -}}
