{{/*
Job for getting user creation & roles
*/}}
{{- define "factory.createAASRolesAndPermissionSecret" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "factory.name" . }}-aas-json
  namespace: {{ .Release.Namespace }}
type: Opaque
data:
  #TODO: the aas-manager.json file needs to be updated for rest of the services
  populate-users.json: {{ tpl (.Files.Get "aas-manager.json") . | b64enc }}
{{- end -}}

{{/*
Job for getting secret from custom-token JSON file
*/}}
{{- define "factory.createCustomClaimsTokenSecret" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "factory.name" . }}-custom-token-json
  namespace: {{ .Release.Namespace }}
type: Opaque
data:
  custom-token.json: {{ tpl (.Files.Get "custom-token.json") . | b64enc }}
{{- end -}}
