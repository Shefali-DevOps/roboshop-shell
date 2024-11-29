LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE
code_dir=$(pwd)

PRINT(){
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo "****************************$****************************" &>>LOG_FILE
  echo $*
}

STAT(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSuccess\e[0m"
  else
    echo -e "\e[31mFailure\e[0m"
    echo
    echo "Refer the log file for more information : file path ${LOG_FILE}"
  fi
}

SYSTEMD_SETUP(){
  PRINT Copy Service file
      cp ${code_dir}/${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
      STAT $?

  PRINT Start Service
     systemctl daemon-reload &>>$LOG_FILE
     systemctl enable ${component} &>>$LOG_FILE
     systemctl restart ${component} &>>$LOG_FILE
     STAT $?
}
NODEJS(){
  PRINT Disable Default Version of nodejs
  dnf module disable nodejs -y &>>LOG_FILE
  STAT $?

  PRINT Enable nodejs 20 module
  dnf module enable nodejs:20 -y &>>LOG_FILE
  STAT $?

  PRINT Install nodejs
  dnf install nodejs -y &>>LOG_FILE
  STAT $?
}

APP_PREREQ(){
  PRINT Adding Application User
  id roboshop &>>LOG_FILE
  if [ $? -ne 0 ] ; then
    useradd roboshop &>>LOG_FILE333
  fi
  STAT $?

  PRINT Remove old content
  rm -rf {$app_path} &>>LOG_FILE
  STAT $?

  PRINT Create APP Directory
  mkdir {$app_path}  &>>LOG_FILE
  STAT $?

  PRINT Download Application Content
  curl -o /tmp/{$component}.zip https://roboshop-artifacts.s3.amazonaws.com/{$component}-v3.zip &>>LOG_FILE
  STAT $?

  PRINT Extract Application Content
  cd {app_path} &>>LOG_FILE
  unzip /tmp/{component}.zip &>>LOG_FILE
  STAT $?
}
