Qu'est-ce qu'une vulnérabilité XSS (Cross-Site Scripting) ?

Une vulnérabilité de type XSS permet à un attaquant d'injecter du contenu malveillant (généralement du JavaScript) dans une page web visitée par d'autres utilisateurs. Ces scripts malveillants s'exécutent dans le contexte du navigateur de la victime, permettant à l'attaquant de voler des cookies, de manipuler le DOM, d'effectuer des actions non autorisées ou d'obtenir des données sensibles.
Types de XSS

    Reflected XSS : Le script malveillant est injecté via une requête et s'exécute immédiatement lorsqu'un utilisateur accède à l'URL contenant le payload.
    Stored XSS : Le script est stocké sur le serveur (dans une base de données, un fichier, etc.) et s'exécute chaque fois que la page concernée est visitée.
    DOM-based XSS : Le script s'exécute dans le navigateur, sans interaction directe avec le serveur, via la manipulation du DOM.