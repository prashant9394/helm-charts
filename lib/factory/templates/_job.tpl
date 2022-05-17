{{/*
Job for getting user creation & roles
*/}}
{{- define "factory.getAasUserAndRoles" -}}
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "factory.name" . }}-aas-manager
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "factory.labelsChart" . | nindent 4 }}
spec:
  template:
    metadata:
      labels:
        {{- include "factory.labelsChart" . | nindent 8 }}
    spec:
      {{- if .Values.global }}
      {{- if .Values.global.image.imagePullSecret }}
      imagePullSecrets:
      - name: {{ .Values.global.image.imagePullSecret }}
      {{- end }}
      {{- else }}
      {{- if .Values.image.aasManager.imagePullSecret }}
      imagePullSecrets:
      - name: {{ .Values.image.aasManager.imagePullSecret }}
      {{- end }}
      {{- end }}
      serviceAccountName: {{ include "factory.name" . }}
      securityContext:
        {{- toYaml .Values.securityContext.aasManagerInit | nindent 8 }}
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
      {{- include "factory.hostAliases" . | nindent 6 }}
      containers:
        - name: {{ include "factory.name" . }}-aas-manager
        {{- if .Values.global }}
          image: {{ .Values.global.image.aasManagerName }}:{{.Chart.AppVersion }}
        {{- else }}
          image: {{ .Values.image.aasManager.name }}:{{.Chart.AppVersion }}
        {{- end }}
        {{- if .Values.global }}
          imagePullPolicy: {{ .Values.global.image.pullPolicy }}
        {{- else }}
          imagePullPolicy: {{ .Values.image.aasManager.pullPolicy }}
        {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext.aasManager | nindent 12 }}
          env:
            {{- if .Values.global }}
              {{- if .Values.global.proxyEnabled }}
              {{- include "factory.globalProxy" . | nindent 12 }}
              {{- end }}
            {{- end }}
          command: ["/bin/sh", "-c"]
          args:
            - >
              echo starting &&
              cat /etc/secrets/populate-users.json &&
              BEARER_TOKEN=$(populate-users --use_json=true --in_json_file=/etc/secrets/populate-users.json | grep BEARER_TOKEN | cut -d '=' -f2) &&
              echo $BEARER_TOKEN &&
              if [ -z "$BEARER_TOKEN" ]; then exit 1; fi &&
              INSTALLATION_TOKEN=`echo $BEARER_TOKEN | cut -d " " -f1` &&
              if [ -z "$INSTALLATION_TOKEN" ]; then exit 1; fi &&
              ./kubectl delete secret {{ include "factory.name" . }}-bearer-token -n {{ .Release.Namespace }} --ignore-not-found  &&
              ./kubectl create secret generic {{ include "factory.name" . }}-bearer-token -n {{ .Release.Namespace }} --from-literal=BEARER_TOKEN=$INSTALLATION_TOKEN &&

              {{ if eq .Chart.Name "kbs" }}
                CUSTOM_CLAIMS_CREATOR_TOKEN=`echo $BEARER_TOKEN | cut -d " " -f2` &&
                if [ -z "$CUSTOM_CLAIMS_CREATOR_TOKEN" ]; then exit 1; fi &&
                ./kubectl delete secret {{ include "factory.name" . }}-custom-claims-creator-token -n {{ .Release.Namespace }} --ignore-not-found  &&
                ./kubectl create secret generic {{ include "factory.name" . }}-custom-claims-creator-token -n {{ .Release.Namespace }} --from-literal=CUSTOM_CLAIMS_CREATOR_TOKEN=$CUSTOM_CLAIMS_CREATOR_TOKEN &&
              {{- end }}
              exit 0
          volumeMounts:
            - name: {{ include "factory.name" . }}-aas-json
              mountPath: /etc/secrets/
              readOnly: true
      volumes:
        - name: {{ include "factory.name" . }}-aas-json
          secret:
            secretName: {{ include "factory.name" . }}-aas-json
{{- end -}}
