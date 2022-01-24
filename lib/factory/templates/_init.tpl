{{/* 
Wait for Database bootstrap
*/}}
{{- define "factory.initWaitForDb" -}}
- name: wait-for-{{ include "factory.name" . }}db
  image: {{ .Values.image.db.name }}
  command: ["/bin/sh", "-c"]
  args:
  - >
    i=0 &&
    while [ -z $(pg_isready -h {{ include "factory.name" . }}db.{{ .Release.Namespace }}.svc.cluster.local -p {{ .Values.config.dbPort }} -U {{ .Values.secret.dbUsername }} | grep "accepting connections") ] && [ $i -lt 5 ]; do  sleep 2; i=$((i+1)); echo "Waiting for {{ include "factory.name" . }} db connection..."; done &&
    if [ $i -eq 5 ]; then echo "Error: timeout exceeded for {{ include "factory.name" . }} db: wait-for-{{ include "factory.name" . }}db"; exit 1; fi
{{- end }}


{{/* 
Wait for CMS-TLS-SHA384, BEARER-TOKEN
*/}}
{{- define "factory.initWaitForCmsSha384BearerToken" -}}
- name: wait-for-cms-sha384-bearer-token
  image: busybox:1.32
  command: ["/bin/sh", "-c"]
  args:
  - >
    i=0 &&
    while [ -z $CMS_TLS_CERT_SHA384 ] && [ ! $(ls /etc/secrets/BEARER_TOKEN 2> /dev/null) ] && [ $i -lt 5 ]; do sleep 5; i=$((i+1)); done &&
    if [ $i -eq 5 ]; then echo "Error: timeout exceeded for init job: wait-for-cms-sha384-bearer-token"; exit 1; fi
  env:
    - name: CMS_TLS_CERT_SHA384
      valueFrom:
        secretKeyRef:
          name: cms-tls-cert-sha384
          key: CMS_TLS_CERT_SHA384
    - name: BEARER_TOKEN
      valueFrom:
        secretKeyRef:
          name: bearer-token
          key: BEARER_TOKEN
  volumeMounts:
    - name: {{ include "factory.name" . }}-secrets
      mountPath: /etc/secrets/
      readOnly: true
{{- end }}


{{/* 
Change Ownership for log path
*/}}
{{- define "factory.initChownLogPath" -}}
- name: chown-log-path
  image: busybox:1.32
  command:
    - /bin/chown
    - -R
    - "{{ .Values.securityContext.init.fsGroup }}"
    - /var/log/isecl-k8s-extensions
  volumeMounts:
    - name: {{ include "factory.name" . }}-log
      mountPath: /var/log/isecl-k8s-extensions
{{- end }}


{{/*
Associate db volume with appropriate version
*/}}
{{- define "factory.initCommonSpecLinkDBVolumes" -}}
- name: link-volumes
  image: busybox:1.32
  command: ["/bin/sh", "-c"]
  args:
    - >
      cd {{ .Values.service.directoryName }} && ln -sfT {{.Chart.AppVersion }}/db db
{{- end }}


{{/*
Associate config and log volumes with appropriate version
*/}}
{{- define "factory.initCommonSpecLinkServiceVolumes" -}}
- name: link-volumes
  image: busybox:1.32
  command: ["/bin/sh", "-c"]
  args:
    - >
      cd {{ .Values.service.directoryName }} &&
      ln -sfT {{.Chart.AppVersion }}/config config &&
      ln -sfT {{.Chart.AppVersion }}/logs logs
{{- end }}