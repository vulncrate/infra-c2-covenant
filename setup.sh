# sets correct linux permissions on ssh keys.
# this does not work in a Windows environment.

mkdir -p /root/.ssh
cp /workspace/ssh/id_rsa.pub /root/.ssh/
cp /workspace/ssh/id_rsa /root/.ssh/

chmod 700 /root/.ssh
chmod 644 /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/id_rsa