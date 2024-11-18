# Beschrijving

Dit is de configuratie van de SlackNotifications-bot. De bot geeft notificaties over Pipelines in AWS en is gekoppeld aan Slack doormiddel van een Kanaal-ID.

# Prerequisite

Om de configuratie uit te voeren zijn de volgende onderdelen nodig:

-   Terraform
-   Codepipelines in AWS
-   Slack Kanaal
-   Maak een AWS Chatbot Slack connectie aan in het AWS Account

# Proces

Het uitvoeren van de configuratie begint met het verzamelen van het ID van het Slack-kanaal en de Amazon Resource Number(s) (ARN) van de AWS Codepipeline(s):

-   Het kanaal-ID is te vinden in de URL van het kanaal waar de bot terechtkomt. Het ID begint met CXXXXXXXX.
-   De ARNs van de Codepipelines kunnen opgevraagt worden met het volgende commando:

Om de ARN van de pipeline op te halen via de CLI gebruik het volgende commando:

```
aws codepipeline get-pipeline --name <naam van pipeline> --query 'metadata.pipelineArn'
```

Het ID van het Slack-kanaal is te vinden in de URL van Slack. De gegevens worden toegevoegd aan het _terraform.tfvars_ bestand op de volgende manier:

```
codenotification_pipeline_arn = ["pipelineArn"]
slack_channel_id = "Kanaal-ID"
```

De Terraform deployment kan nu uitgevoerd worden. Navigeer met de terminal naar de cloned repo waar de Terraform configuratie staat. Voer vervolgens de volgende stappen één voor één uit:

```
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars" -auto-approve
```

# Postconditie

Na het uitvoeren van de commando's geeft Terraform weer dat de deployment is geslaagd. Hiermee is er een AWS Chatbot toegevoegd aan het kanaal dat is meegegeven als variabel en zijn er notificatie regels toegevoegd aan de pipelines die zijn meegegeven als variabel. De notificatie bot zal op de volgende events een bericht sturen:

-   Pipeline Exection
    -   Started
    -   Succeeded
    -   Failed
-   Manual approval
    -   Succeeded
    -   Needed

# Toelichting

## Commando's

“Terraform init”: is het commando dat ervoor zorgt dat de working directory geïnitialiseerd wordt.

“Terraform plan”: is het commando dat naar de deployment kijkt en als output de potentiële deployment weergeeft. Mocht er iets fout staan in de deployment, komt dat als output mee.
“Terraform apply”: is het commando dat de deployment uitvoert.

## Options

“-var-file=”: Verwijst naar het .tfvars variabel bestand en neemt dit mee als variabele input.

“-auto-approve”: De option vraagt niet om een tweede controle wanneer de deployment uitgevoerd wordt. De controle wordt uitgevoerd tijdens het “terraform plan” commando.

## Bekende Errors

-   updating AWS Chatbot Slack Channel Configuration/Operation Error chatbot: UpdateSlackChannelConfiguration https response error Statuscode 400. Slack channel with ID in Slack Team has already been configured for AWS account.

De error komt voor wanneer er al een chatbot aanwezig is op het Slack kanaal. De oplossing is om de chatbot configuratie in AWS te verwijderen of om de notificatie regel aan de configuratie toe te voegen.
