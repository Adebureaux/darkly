In the http://192.168.1.32/?page=feedback page, there is a HTML form described as follow:
<form method="post" name="guestform" onsubmit="return validate_form(this)">
  <input name="txtName" type="text" size="30" maxlength="10">
  <textarea name="mtxtMessage" cols="50" rows="3" maxlength="50"></textarea>
  <input name="btnSign" type="Submit" value="Sign Guestbook" onclick="return checkForm();">
</form>

Trying multiple payload and find out that if the message contain a special character as : \ / `` '' | 