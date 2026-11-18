## Description
This is a capture the flag repository.

Each folder is a challenge, with a clear procedure to resolve.

## Challenges

### open-http-easypass
This challenge is very simple, this server has 3 ports open:
- 80: running a hello world Nginx
- 443: running a hello world Nginx serving /tmp/passwd content

The structure of this challenge is:
1. The whole structure will run in a docker container
2. The container will do, every startup, run a random password with 6 chars and write it to /tmp/passwd
3. It will change the root password to the password written on  /tmp/passwd
4. Every time the container restarts, it will redoo the whole process.

### open-tcp-easypass
This challenge is very simple, this server has 1 ports open:
- 10051: A python code will be running at that port printing the content of /tmp/passwd

The structure of this challenge is:
1. The whole structure will run in a docker container
2. The container will do, every startup, run a random password with 6 chars and write it to /tmp/passwd
3. It will change the root password to the password written on  /tmp/passwd
4. Every time the container restarts, it will redoo the whole process.

