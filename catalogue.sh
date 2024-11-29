source common.sh
component=catalogue
app_path=/app

NODEJS
SYSTEMD_SETUP
APP_PREREQ
cp mongo.repo /etc/yum.repos.d/mongo.repo
npm install
dnf install mongodb-mongosh -y
mongosh --host 172.31.89.237 </app/db/master-data.js