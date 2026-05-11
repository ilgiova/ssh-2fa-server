#!/bin/bash

echo "=== Initializing SSH Server with 2FA ==="

# Read the first line from the /user.txt file
IFS=':' read -r username password < "/user.txt"

echo "----------------------------------------"
echo "Configuring account: $username"

useradd -m -s /bin/bash "$username"
echo "$username:$password" | chpasswd

# Flags explanation:
# -t : Use Time-based tokens
# -d : Disallow reuse of the same token
# -f : Force silent execution without asking for confirmation
# -r 3 -R 30 : Rate limiting (max 3 attempts every 30 seconds)
# -W : Minimize the time window for token validity
su -c "google-authenticator -t -d -f -r 3 -R 30 -W" "$username"

echo "=== Configuration complete. Starting SSH Daemon... ==="
exec /usr/sbin/sshd -D
