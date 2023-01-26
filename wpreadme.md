# Benvenuti nel progetto Wordpress-Terraform

## Prerequisiti
Questo progetto richiede che nel sistema operativo siano installati i seguenti file binari:


Terraform - https://www.terraform.io/downloads.html

AWS CLI - https://aws.amazon.com/cli/

Inoltre è necessario avere:

Un account AWS
Un utente IAM con privilegi di amministrazione.
  
## 1 - CONFIGURAZIONE INIZIALE

## 1.1 - Clonare il repository 

   - Vai all'URL: https://github.com/D3luX8/terraform-wordpress.git 
    
   - Fai clic sul pulsante verde CODE in alto a destra e seleziona DOWNLOAD ZIP

   - Salvare il file in una cartella a propria scelta, di cui l'utente dispone dell'autorizzazione completa.
   
   - Una volta scaricato, vai in quella cartella ed estrai il contenuto del file zip nella stessa.
   
## 1.2 - Configurazione del profilo AWS

   - Vai alla console di gestione AWS e accedi con le tue credenziali AWS IAM: 
     https://us-east-2.console.aws.amazon.com/console/home?region=us-east-2

   - Una volta effettuato l'accesso, cerca il servizio IAM nella barra di ricerca in alto al centro e seleziona l'opzione del servizio IAM.

   - Dalla dashboard di IAM, seleziona l'opzione Utenti dal riquadro di sinistra.

   - Seleziona l'utente che desideri utilizzare per creare le risorse AWS dal campo Nome utente.

   - Seleziona la scheda Credenziali di sicurezza e fare clic su Crea chiavi di accesso.
   
   - Copia l'ID chiave di accesso e la chiave di accesso segreta e incollarli in un editor di testo a scelta.
     Nota: Devi fare clic sul pulsante "Mostra" prima di copiare la chiave di accesso segreta.
	 
	 
   - Apri un terminale sul tuo computer.
   
   - Esegui il seguente comando per configurare il tuo nuovo profilo AWS:
     aws configure
	 
   - Alla voce AWS Access Key ID [None]: inserisci l'ID chiave di accesso ottenuta prima e premi invio.
   - Alla voce AWS Secret Access Key [None]: inserisci la chiave di accesso segreta ottenuta prima e premi invio.
   - Alla voce Default region name [None]: digita us-east-2
   - Alla voce Default output format [None]: digita table
   
   - Verifica che il tuo nuovo profilo AWS sia stato creato eseguendo il seguente comando:
     aws configure list-profiles
	 
	 
## 2 - AVVIO DEL PROGETTO

## 2.1 - Inizializzazione Terraform

   - Dal terminale, passa alla directory del progetto creata nella Sezione 1.1
   
   - Esegui il seguente comando per inizializzare Terraform:
     terraform init
	 
   - I moduli e i plugin necessari per il progetto Terraform verranno ora scaricati.
   
   - Una volta che Terraform è stato inizializzato correttamente, puoi procedere al prossimo step.
   
## 2.2 - Controlli di configurazione

   - Dal terminale, esegui il comando seguente per pianificare e verificare la configurazione del progetto Terraform:
     terraform plan --var-file=configuration/dev.tfvars
	 
   - Terraform scorrerà la configurazione e verificherà che tutto sia a posto. Verrà prodotto l'output della configurazione
   
   
## 2.3 - Avvio di Terraform

   Nota: Procedere solo se i controlli di configurazione della Sezione 2.2 hanno avuto esito positivo.
   
   - Dal terminale, esegui il comando seguente per applicare e avviare il progetto Terraform:
     terraform apply --var-file=configuration/dev.tfvars
	 
   - Terraform elaborerà la configurazione inserendo automaticamente le variabili contenute nel file configuration/dev.tfvars e richiederà se si desidera procedere, con la seguente domanda: Do you want to perform these actions?
   
   - Digita yes e premi invio per continuare. Terraform procederà a creare le risorse in AWS e produrrà l'output man mano che procede
     Nota: Questo potrebbe richiedere del tempo, pazienta fin quando l'output non sarà completo.
	 
	 
## 3 - ACCESSO AL SITO WEB DI WORDPRESS

   - Una volta ottenuto esito positivo alla fine dei passaggi della Sezione 2.3 , apri una nuova scheda nel tuo browser preferito
   
   - Vai alla console di gestione AWS e accedi con le tue credenziali AWS IAM: 
     https://us-east-2.console.aws.amazon.com/console/home?region=us-east-2
	 
   - Nel menù sulla sinistra, alla voce Bilanciamento del carico, clicca su Sistemi di bilanciamento del carico
   
   - Nell'elenco dei Load Balancers, clicca sulla voce DNS NAME per copiarne l'URL.
   
   - Apri una nuova scheda nel browser, incolla l'URL appena copiato e verrai indirizzato alla pagina web appena creata
	 
	 
	 
   
   
	 
## Descrizione
Questo progetto crea e utilizza le seguenti risorse:

    • VPC (Virtual Private Cloud)
    • Security Groups
    • Auto Scaling Group
    • Load Balancer
    • RDS
    • EC2 Instance
    • Autoscaling

### Vpc
- Viene creato un VPC con 2 sottoreti pubbliche e 2 sottoreti private. Le sottoreti pubbliche conterranno un gateway internet mentre le sottoreti private avranno un gateway NAT. I valori necessari per il modulo VPC vengono passati tramite il file variable.tf mentre i valori del modulo VPC necessari per altri moduli vengono passati tramite il file output.tf.

### Security Group
- Questo modulo creerà tutti i gruppi di sicurezza necessari per l'applicazione. Verranno creati gruppi di sicurezza separati per il server web-app, RDS e il load balancer.

### RDS
- Viene creata un'istanza RDS che fungerà da database. Le credenziali del database verranno passate utilizzando i parametri SSM (Simple Systems Manager).

### EC2 
- Il modulo EC2 creerà un'istanza in una sottorete privata che fungerà da server web e un'istanza "Bastion host" in una sottorete pubblica che verrà utilizzata per accedere al server web.

### Load Balancer
- Viene creato un load balancer che sarà rivolto verso internet e indirizzerà tutto il traffico in arrivo dalla rete esterna al server web. Sul bilanciatore di carico gli accessi sono consentiti attraverso le porte 80 e 443.

### Auto Scaling Group
- Il modulo ASG (Auto Scaling Group) creerà un gruppo di scalabilità automatica che scalerà automaticamente il server web in base al numero massimo e minimo impostato.
