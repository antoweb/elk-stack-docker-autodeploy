Setup winlogbeat su Windows
Video youtube: https://www.youtube.com/watch?v=grloDtOS21c
Scaricare winlogbeat da https://www.elastic.co/downloads/beats/winlogbeat
Unzippare il file in c:\ e rinominare la cartella in c:\winlogbeat
Editare il file winlogbeat.yml come segue


Inserire alla riga 23 prima di winlogbeat.event_logs la riga seguente

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

Decommentare la linea seguente:

  host: "10.21.20.15:5601"

E inserire indirizzo ip del server elk

Per il blocco seguente modificare
- Ip del server elk (hosts)
- Username e password di default elastic/changeme

# ---------------------------- Elasticsearch Output ----------------------------
output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["10.21.20.15:9200"]
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
- Lanciare il comando di creazione dashboard: .\winlogbeat.exe setup --dashboards
- Attendere l'esito "Loaded Dashboard"
- Lanciare il comando: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
- Installare il servizio winlogbeat col comando: ./install-service-wunlogbeat.ps1
- Avviare il servizio dalla console servizi di windows
Verificare che l'indice ci sia alla url: http://10.21.20.15:9200/_cat/indices?v


Andare sull'interfaccia ELK all'indirizzo https://IP-SERVER-ELK:5601
Login: elastic/changeme

Verificare che ci sia la dashboard winlogbeat
