Setup winlogbeat su Windows
Video youtube: https://www.youtube.com/watch?v=grloDtOS21c
Scaricare winlogbeat da https://www.elastic.co/downloads/beats/winlogbeat
Unzippare il file in c:\ e rinominare la cartella in c:\winlogbeat
Editare il file winlogbeat.yml come segue (usare il file winlogbeat.yml di questa repository come esempio)

Inserire in una riga vuota prima di winlogbeat.event_logs la riga seguente

output.elasticsearch.allow_older_versions: true

Il blocco seguente riporta quali eventi devono essere inviati a lgstash:
winlogbeat.event_logs:
  - name: Application
    ignore_older: 72h

  - name: System

  - name: Security

  - name: ForwardedEvents
    tags: [forwarded]

  - name: Windows PowerShell
    event_id: 400, 403, 600, 800

  - name: Microsoft-Windows-PowerShell/Operational
    event_id: 4103, 4104, 4105, 4106

Per il blocco seguente:

setup.kibana:

  # Kibana Host
  # Scheme and port can be left out and will be set to the default (http and 5601)
  # In case you specify and additional path, the scheme is required: http://localhost:5601/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
  host: "localhost:5601"

Decommentare setup.kibana e nella riga host inserire l'ip del server elk al posto di localhost

Per il blocco seguente modificare
- Ip del server elk (hosts) al posto di localhost
- Username e password di default elastic/changeme

# ---------------------------- Elasticsearch Output ----------------------------
output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["localhost:9200"]
  #ssl.enabled: true

  # Protocol - either `http` (default) or `https`.
  #protocol: "https"

  # Authentication credentials - either API key or username/password.
  #api_key: "id:api_key"
  username: "elastic"
  password: "changeme"


Salvare e chiudere il file

Testare la configurazione come segue:

- Aprire una finestra powershell e posizionarsi in c:\winlogbeat
- Lanciare il comando: .\winlogbeat.exe test config -c .\winlogbeat.yml -e
- Verificare che esito sia ok
- Lanciare il comando di creazione dashboard: .\winlogbeat.exe setup --dashboards  (solo su una macchina della rete)
- Attendere l'esito "Loaded Dashboard"
- Lanciare il comando: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
- Installare il servizio winlogbeat col comando: ./install-service-wunlogbeat.ps1
- Avviare il servizio dalla console servizi di windows
Verificare che l'indice ci sia alla url: http://10.21.20.15:9200/_cat/indices?v


Andare sull'interfaccia ELK all'indirizzo https://IP-SERVER-ELK:5601
Login: elastic/changeme

Verificare che ci sia la dashboard winlogbeat

--------------------------------------------
---	INSTALLAZIONE filebeat per WINDOWS ---
--------------------------------------------
- Scaricare l'agent in formato zip da qui: https://www.elastic.co/downloads/beats/filebeat
- Scegliere Windows zip format
- Creare una cartella in c:\filebeat
- Decomprimere lo zip in quella cartella
- Editare il file filebeat.yml come segue:

Aggiungere la seguente riga in una riga vuota prima di filebeat.inputs:
output.elasticsearch.allow_older_versions: true


Editare il blocco seguente aggiungendo il path completo di un file di log dainviare al server elk
(attenzione se il file contiene spazi nel path inserirlo tra apici doppi e usare slash invece di backslah, es: "c:/program files/"
filebeat.inputs:

# Each - is an input. Most options can be set at the input level, so
# you can use different inputs for various configurations.
# Below are the input specific configurations.

# filestream is an input for collecting log messages from files.
- type: filestream

  # Unique ID among all inputs, an ID is required.
  id: my-filestream-id

  # Change to true to enable this input configuration.
  enabled: true

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    #- /var/log/*.log
    #- c:\programdata\elasticsearch\logs\*
    - "C:/Program Files (x86)/TeamViewer/Update/TV15Install.log"

- Aprire una powershell e lanciare i comandi seguenti:

- Aprire una finestra powershell e posizionarsi in c:\filebeat
- Lanciare il comando: .\filebeat.exe test config -c .\filebeat.yml -e
- Verificare che esito sia ok
- Lanciare il comando di creazione dashboard: .\filebeat.exe setup --dashboards (solo su una macchina della rete)
- Attendere l'esito "Loaded Dashboard"
- Lanciare il comando: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
- Installare il servizio winlogbeat col comando: ./install-service-filebeat.ps1
- Avviare il servizio dalla console servizi di windows
Verificare che l'indice ci sia alla url: http://10.21.20.15:9200/_cat/indices?v

--------------------------------------------
---	INSTALLAZIONE filebeat per LINUX ---
--------------------------------------------

Usare repository yum o scaricare da qui
https://www.elastic.co/downloads/beats/filebeat

- Usare il file /etc/filebeat/filebeat.yml come esempio di configurazione (simile a windows)
- Importante aggiungere in una riga vuota la direttiva:
	output.elasticsearch.allow_older_versions: true
- Modificare sezioni output.elasticsearch e kibana l'ip dell'host
- Modificare la sezione filebeat.inputs: inserendo i file da monitorare (vedi esempio filebeat.ym)
- lanciare il comando
	filebeat setup dashboard
- Riavviare servizio filebeat
