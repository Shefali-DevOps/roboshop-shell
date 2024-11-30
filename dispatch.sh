source common.sh
component=dispatch
app_path=/app

SYSTEMD_SETUP

PRINT Install Golag
dnf install golang -y &>>LOG_FILE
STAT $?

APP_PREREQ

PRINT Download Dependencies
go mod init dispatch &>>LOG_FILE
go get &>>LOG_FILE
go build &>>LOG_FILE
STAT $?

