# Setup Tasks
Each ISecl Serivces can be configured by running appropriate setup tasks. These setup tasks perform specific task such
as regenerating tls certificate, updating the configuration and few other tasks specific to services.

Check this document for available setup tasks for each of the services  [Setup tasks](setup-tasks.md) 

1. Edit the configmap of respective service where we want to run setup task. e.g ```kubectl edit cm cms -n isecl```
2. Add or Update all the variables required for setup tasks refer [here](setup-tasks.md)  for more details
3. Add *SETUP_TASK* variable in config map with one or more setup task names e.g ```SETUP_TASK: "download-ca-cert,download-tls-cert"```
4. Save the configmap
5. Some of the sensitive variables such as credentials, db credentials, tpm-owner-secret can be updated in secrets with the command 

    ```kubectl get secret -n <namespace> <secret-name> -o json | jq --arg val "$(echo <value> > | base64)" '.data["<variable-name>"]=$val' | kubectl apply -f -```
    
    e.g For updating the AAS_ADMIN_USERNAME in aas-credentials 
    
    ```kubectl get secret -n isecl aas-credentials -o json | jq --arg val "$(echo aaspassword | base64)" '.data["AAS_ADMIN_USERNAME"]=$val' | kubectl apply -f -``` 
   
6. Restart the pod by deleting it ```kubectl delete pod -n <namespace> <podname>```
7. Reset the configmap by removing SETUP_TASK variable 

      ```kubectl patch configmap -n <namespace> <configmap name> --type=json -p='[{"op": "remove", "path": "/data/SETUP_TASK"}]'```
        
        e.g For clearing SETUP_TASK variable in cms configmap
        
      ```kubectl patch configmap -n isecl cms --type=json -p='[{"op": "remove", "path": "/data/SETUP_TASK"}]'```
