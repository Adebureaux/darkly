 J'ai une page pour retrouver le mot de passe mais c'est bizarre je n'ai pas de champs de saisie pour un mail ou autre!

 Dans le code source de la page:
 <form action="#" method="POST">
	<input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">
	<input type="submit" name="Submit" value= "Submit">
</form>

1. Analyser la requête envoyée

Lorsque on clique sur "Submit", une requête POST est envoyée au serveur avec le champ caché mail contenant l'adresse webmaster@borntosec.com. 

2. Modifier la requête avec un proxy (Burp Suite)

On utilise Burp Suite pour intercepter cette requête. On modifie la valeur de l'entrée mail pour y inscrire une autre adresse, par exemple :

mail=your_email@example.com

Si le serveur n'effectue pas de vérification supplémentaire (comme la validation côté serveur), il pourrait envoyer le mot de passe ou des informations sensibles à l'adresse email que vous avez spécifiée.

Et hop!
The flag is : 1d4855f7337c0c14b6f44946872c4eb33853f40b2d54393fbe94f49f1e19bbb0


Ce que cela signifie :

    Manque de validation côté serveur : Le serveur suppose que les données du formulaire sont fiables. Cependant, comme un attaquant peut manipuler les données client avant qu'elles ne soient envoyées, cette hypothèse est incorrecte.
    Risque potentiel : Si le mot de passe est envoyé par email, cette méthode pourrait permettre à un attaquant de détourner l'information.


-----------------------------------------------------------------------------------
Résolution de la vulnérabilité :

Pour prévenir ce type de vulnérabilité, il est essentiel que :

    Validation côté serveur :
        Le serveur doit vérifier que l'email appartient à un utilisateur légitime et ne pas faire confiance à la valeur envoyée par le client.
        Un email généré par le client (via une entrée cachée ou tout autre champ) ne devrait pas être utilisé sans vérification.

    Supprimer les champs cachés inutiles :
        Au lieu de transmettre directement l'email via une entrée masquée, utilisez un identifiant sécurisé (par exemple, un token unique) généré côté serveur.

    Configurer des journaux :
        Enregistrer les tentatives de récupération de mot de passe pour détecter tout comportement anormal ou malveillant.