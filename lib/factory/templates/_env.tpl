
{{/*
Env for CMS_TLS_SHA384
*/}}
{{- define "factory.envCmsSha384" -}}
- name: CMS_TLS_CERT_SHA384
  valueFrom:
    secretKeyRef:
      name: cms-tls-cert-sha384
      key: CMS_TLS_CERT_SHA384
{{- end }}


{{/*
Env for BEARER_TOKEN
*/}}
{{- define "factory.envBearerToken" -}}
- name: BEARER_TOKEN
  valueFrom:
    secretKeyRef:
      name: bearer-token
      key: BEARER_TOKEN
{{- end }}


{{/*
Env for PostgresDB
*/}}
{{- define "factory.envPostgres" -}}
- name: POSTGRES_DB
  value: {{ .Values.config.dbName }}
- name: POSTGRES_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "factory.name" . }}db-credentials
      key: {{ .Values.config.envVarPrefix }}_DB_USERNAME
- name: POSTGRES_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "factory.name" . }}db-credentials
      key: {{ .Values.config.envVarPrefix }}_DB_PASSWORD
- name: PGDATA
  value: /var/lib/postgresql/data/pgdata
{{- end }}


{{/*
Env for PostgresDB Without Prefix
*/}}
{{- define "factory.envPostgresWithoutPrefix" -}}
- name: POSTGRES_DB
  value: {{ .Values.config.dbName }}
- name: POSTGRES_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "factory.name" . }}db-credentials
      key: DB_USERNAME
- name: POSTGRES_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "factory.name" . }}db-credentials
      key: DB_PASSWORD
- name: PGDATA
  value: /var/lib/postgresql/data/pgdata
{{- end }}