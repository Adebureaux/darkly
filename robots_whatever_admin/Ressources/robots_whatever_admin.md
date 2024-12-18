Here is the requested write-up focused on the `robots.txt` exploit:

---

# Write-Up: Exploiting robots.txt for Admin Access

## Exploit Overview

This write-up details the steps taken to exploit a vulnerability involving the `robots.txt` file and subsequent attempts to gain administrator access to a web application.

---

### Step 1: Analyze robots.txt

The `robots.txt` file provides directives to web crawlers about which paths to avoid. We accessed it to identify potentially hidden directories or files.

#### URL
```
http://192.168.1.33/robots.txt
```

#### Contents
```
User-agent: *
Disallow: /whatever
Disallow: /.hidden
```

From this, we focus on the `/whatever` directory.

---

### Step 2: Inspect the `/whatever` Directory

We navigated to `/whatever` and discovered a file named `htpasswd` containing the following credentials:

```
root:437394baff5aa33daa618be47b75cb49
```

#### Decode the Hash
Using [hashes.com](https://hashes.com/en/decrypt/hash), the hash `437394baff5aa33daa618be47b75cb49` was decoded to:

- **Password:** `qwerty123@`

---

### Step 3: Attempt Login

We attempted to log in using the `root` username and the decoded password `qwerty123@` on the main login page, but it did not succeed.

---

### Step 4: Find Admin Interface

We searched for common admin interfaces and located the following:

#### URL
```
http://192.168.1.33/admin/
```

This page contained username and password fields.

#### Credentials Used
- **Username:** `root`
- **Password:** `qwerty123@`

#### Result
- **Success:** Admin access granted.

---

## How to Protect Against Such Attacks

To prevent similar exploits, implement the following measures:


1. **Avoid Storing Passwords in Plaintext or Reversible Hashes:**
   - Use strong hashing algorithms such as bcrypt or Argon2 to store passwords securely.

2. **Disable Directory Listing:**
   - Configure the web server to prevent directory listing to avoid exposing sensitive files.

3. **Use Environment Variables for Sensitive Data:**
   - Store sensitive credentials like database usernames and passwords in environment variables, not in publicly accessible files.

By implementing these protections, web applications can significantly reduce the risk of exploits leveraging publicly accessible files like `robots.txt` or `.htpasswd`.

---

## Summary

Through the exploitation of `robots.txt`, we identified hidden directories, retrieved hashed credentials from an `.htpasswd` file, and used them to successfully access the admin panel of a web application. This highlights the importance of securing sensitive files and directories to prevent unauthorized access.

---
