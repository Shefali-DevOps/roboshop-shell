LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE
code_dir=$(pwd)

PRINT(){
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo "****************************$1***************************" &>>LOG_FILE
  echo &>>LOG_FILE
}

SYSTEMD_SETUP(){
  PRINT Copy Service file
      cp ${code_dir}/${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
      STAT $?

  PRINT Start Service
     systemctl daemon-reload
     systemctl enable ${component}
     systemctl restart ${component}
}
