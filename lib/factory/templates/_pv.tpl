
{{/*
PV for config
*/}}
{{- define "factory.pvConfigCommonSpec" -}}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ include "factory.name" . }}-config
spec:
  capacity:
    storage: {{ .Values.storage.nfs.configSize }}
  volumeMode: Filesystem
  accessModes:
    - {{ .Values.storage.nfs.accessModes }}
  persistentVolumeReclaimPolicy: {{ .Values.storage.nfs.reclaimPolicy }}
  claimRef:
    namespace: {{ .Release.Namespace }}
    name: {{ include "factory.name" . }}-config
{{- end -}}


{{/*
PV for logs
*/}}
{{- define "factory.pvLogsCommonSpec" -}}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ include "factory.name" . }}-logs
spec:
  capacity:
    storage: {{ .Values.storage.nfs.logsSize }}
  volumeMode: Filesystem
  accessModes:
    - {{ .Values.storage.nfs.accessModes }}
  persistentVolumeReclaimPolicy: {{ .Values.storage.nfs.reclaimPolicy }}
  claimRef:
    namespace: {{ .Release.Namespace }}
    name: {{ include "factory.name" . }}-logs
{{- end -}}


{{/*
PV for DB
*/}}
{{- define "factory.pvDbCommonSpec" -}}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ include "factory.name" . }}db
spec:
  capacity:
    storage: {{ .Values.storage.nfs.dbSize }}
  volumeMode: Filesystem
  accessModes:
    - {{ .Values.storage.nfs.accessModes }}
  persistentVolumeReclaimPolicy: {{ .Values.storage.nfs.reclaimPolicy }}
  claimRef:
    namespace: {{ .Release.Namespace }}
    name: {{ include "factory.name" . }}db
{{- end -}}

{{/*
PV for DB
*/}}
{{- define "factory.pvBaseCommonSpec" -}}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ include "factory.name" . }}-base
spec:
  capacity:
    storage: {{ .Values.storage.nfs.baseSize }}
  volumeMode: Filesystem
  accessModes:
    - {{ .Values.storage.nfs.accessModes }}
  persistentVolumeReclaimPolicy: {{ .Values.storage.nfs.reclaimPolicy }}
  claimRef:
    namespace: {{ .Release.Namespace }}
    name: {{ include "factory.name" . }}-base
{{- end -}}