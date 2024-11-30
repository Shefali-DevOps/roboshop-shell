source common.sh
component=frontend
app_path=/usr/share/nginx/html

PRINT Disable nginx default version
dnf module disable nginx -y &>>LOG_FILE
STAT $?

PRINT Enable Nginx 24 version
dnf module enable nginx:1.24 -y &>>LOG_FILE
STAT $?

PRINT Install Nginx
dnf install nginx -y &>>LOG_FILE
STAT $?

PRINT Copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf &>>LOG_FILE
STAT $?


APP_PREREQ

PRINT Start and Enable Nginx service
systemctl enable nginx &>>LOG_FILE
systemctl restart nginx &>>LOG_FILE
STAT $?

