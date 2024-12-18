## Exploitation of a Vulnerability via `robots.txt`

### Vulnerability Description

In this exploitation, we leveraged the `robots.txt` file located at the following address:

```
http://192.168.1.33/robots.txt
```

Content of `robots.txt`:

```
User-agent: *
Disallow: /whatever
Disallow: /.hidden
```

The `Disallow: /.hidden` directive tells web crawlers not to index this directory. However, this directive also signals attackers about potentially "interesting" areas on the server. We targeted the **/.hidden** directory for further investigation.

### Directory Exploration

Upon accessing `/hidden`, the following content was revealed:

```
Index of /.hidden/

../
amcbevgondgcrloowluziypjdh/    29-Jun-2021 18:15
bnqupesbgvhbcwqhcuynjolwkm/    29-Jun-2021 18:15
...
README                         29-Jun-2021 18:15    34
```

This directory contains a complex hierarchical structure with multiple subdirectories. Each subdirectory contains a `README` file with messages like: *"Ask your neighbor to the right/left/above..."*.

### Automation

Manually exploring each subdirectory would be extremely tedious. Here are the steps we followed to automate the process:

#### Step 1: Download All Files

We used a script to crawl through the directory structure and download all files available within the subdirectories.

#### Step 2: Search for the Flag

After downloading, a second script was executed to search for keywords such as **flag** or specific patterns within the `README` files.

Result of the search:

```
README18279 => 18279 files downloaded.
Match found in ./downloaded_files/README15694:
flag
```

The file `README15694` contained the keyword **flag**, which was our objective.

---

### How to Protect Against This Vulnerability

1. **Restrict Access to Sensitive Directories:**
   - Prevent public access to directories like **/.hidden** by properly configuring permissions.
   - Use server rules (e.g., `.htaccess` for Apache) to restrict access.

2. **Use a Judicious `robots.txt` File:**
   - Avoid listing sensitive directories in `robots.txt`.
   - Instead, use alternative methods such as `noindex` meta tags or IP restrictions to secure critical areas.

3. **Monitor Server Access:**
   - Implement monitoring tools to detect unusual access to non-indexed directories.

5. **Obfuscate Sensitive Directories:**
   - Rename sensitive directories with non-intuitive or dynamic names to prevent accidental or intentional discovery.

---
