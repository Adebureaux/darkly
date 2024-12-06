Alors dans cette faille, on a utilisé robots.txt:

http://192.168.1.33/robots.txt

User-agent: *
Disallow: /whatever
Disallow: /.hidden

Ici nous nous interesserons au dossier /whatever
qui contient htpasswd qui contient:
root:437394baff5aa33daa618be47b75cb49

On le decode avec https://hashes.com/en/decrypt/hash
437394baff5aa33daa618be47b75cb49:qwerty123@

on a essayé de se log avec root et qwerty123@ sur la page principale mais ça n'a pas fonctionné!

On a cherché des interfaces administrateurs standards:
http://192.168.1.33/admin/

avec un champs username et password!
On essaye root et qwerty123@ et banco! c'est bon!