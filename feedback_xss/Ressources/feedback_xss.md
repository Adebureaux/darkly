In the http://192.168.1.32/?page=feedback page, there is a HTML form described as follow:
<form method="post" name="guestform" onsubmit="return validate_form(this)">
  <input name="txtName" type="text" size="30" maxlength="10">
  <textarea name="mtxtMessage" cols="50" rows="3" maxlength="50"></textarea>
  <input name="btnSign" type="Submit" value="Sign Guestbook" onclick="return checkForm();">
</form>

Trying multiple payloads and find out that if the message contain only one character in the "txtName" or "txtMessage" field, it displays the flag.

After a few tests, the flag is not displayed on all characters, we tried with many different. It's look like: "a", "e", "r", "t", "i", "p", "s", "l", "c" wich is an anagram of the word "particles".

A way to fix this issue would be to satinize the input before sending it to the database. The server could easyly perform verifications about the length of the string and the charcaters that are present in it.
