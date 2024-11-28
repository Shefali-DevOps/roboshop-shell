cp shipping.service /etc/systemd/system/shipping.service
dnf install maven -y
useradd roboshop
rm -rf /app
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
