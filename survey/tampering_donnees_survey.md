Description du problème

on est face à un formulaire de vote où les utilisateurs peuvent voter en attribuant une note à différents sujets (entre 1 et 10). Cependant, en interceptant la requête HTTP avec un outil comme Burp Suite, on remarque que les restrictions côté client (limite entre 1 et 10) ne sont pas appliquées côté serveur.
Étapes de la solution

    Observation initiale :
        En analysant le formulaire via notre navigateur, on constate que les notes étaient limitées (1 à 10).
        
    Interception et modification de la requête :
        on intercepte la requête POST envoyée au serveur lors de l'envoi du vote :

    POST /?page=survey HTTP/1.1
    Host: 192.168.1.33
    Content-Length: 16
    Content-Type: application/x-www-form-urlencoded

    sujet=2&valeur=2

   On modifie la valeur valeur=2 pour valeur=100000000000 dans le corps de la requête.

Soumission et obtention du flag :

    En envoyant cette requête modifiée, on a réussi à "voter" avec une valeur démesurément élevée.
    Le serveur, ne validant pas la valeur côté serveur, a accepté la requête et a généré le flag en retour.

The flag is 03a944b434d5baff05f46c4bede5792551a2595574bcafc9a6e25f67c382ccaa

Prévention

Pour éviter ce type de vulnérabilité, appliquez ces bonnes pratiques :

    Validation côté serveur :
        Limitez les valeurs des paramètres à des plages spécifiques (ici, entre 1 et 10) via des vérifications serveur.

    Exemple en PHP :

if ($valeur < 1 || $valeur > 10) {
    die("Valeur invalide !");
}
