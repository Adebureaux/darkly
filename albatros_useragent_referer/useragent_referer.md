En cliquant sur born to sec tout en bas de la page principale
http://192.168.1.33/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f

une page sur les albatros...

En affichant le code source de la page plein d'infos sont cachées tout en bas!

Surtout 2:
<!--
You must come from : "https://www.nsa.gov/".
-->
et
<!--
Let's use this browser : "ft_bornToSec". It will help you a lot. 
-->
(tout à droite:)

A partir de là c'est simple!
On intercepte la requete et on va lui rajouter un referer ("https://www.nsa.gov/") et un user_agent ("ft_bornToSec")


Définit l'en-tête HTTP Referer pour simuler que vous venez du site de la NSA.


GET /?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f HTTP/1.1
Host: 192.168.1.33
Accept-Language: fr-FR,fr;q=0.9
Upgrade-Insecure-Requests: 1
User-Agent: ft_bornToSec
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate, br
Referer: https://www.nsa.gov/
Cookie: I_am_admin=68934a3e9455fa72420237eb05902327
Connection: keep-alive





-------------------------
--------------------------------------------------------
--------------------------

Qu'est ce au'un user_agent:
Un User-Agent est une chaîne de texte incluse dans les requêtes HTTP envoyées par un navigateur, une application ou un script client pour s'identifier auprès d'un serveur. Cette chaîne contient des informations sur :

    Le logiciel client utilisé (navigateur web, outil automatisé comme curl, etc.).
    Le système d'exploitation du client (par exemple, Windows, Linux, Android).
    La version du logiciel ou du système.

À quoi sert un User-Agent ?

    Personnalisation de la réponse du serveur :
        Les serveurs web peuvent adapter le contenu qu'ils renvoient en fonction du User-Agent. Par exemple :
            Un site web peut fournir une version optimisée pour mobile si le User-Agent indique que le client est un navigateur mobile.
            Des outils comme Googlebot (utilisés par les moteurs de recherche) reçoivent un contenu spécifique pour l'indexation.

    Suivi et Analyse :
        Les administrateurs de sites utilisent les User-Agents pour analyser les visiteurs de leur site (par exemple, pour savoir quel navigateur ou système d'exploitation est le plus utilisé).

    Restrictions et accès conditionnel :
        Un serveur peut restreindre l'accès à certains contenus ou fonctionnalités en vérifiant le User-Agent. Par exemple :
            Autoriser seulement des navigateurs spécifiques ou des outils reconnus (comme un certain User-Agent dans votre cas).

    Débogage et Automatisation :
        Les outils comme curl ou wget utilisent des User-Agents personnalisés pour imiter des navigateurs ou applications dans le cadre d’automatisation ou de tests.

