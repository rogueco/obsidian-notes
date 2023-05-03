# How to Deploy To Digital Ocean

Created: March 26, 2021 3:09 PM

<aside>
💡 Use this template to describe the steps engineers should follow to deploy.

</aside>

# 1. Ping in Slack #deploys channel

Let everyone know you're about to start a deploy. 

# 2. SSH into the deployment server

<aside>
💡 Create a code block by typing `/code` and pressing `enter`.

</aside>

```bash
ssh deployments.acmecorp.com
```

- You can create `inline code snippets` with the shortcut `cmd/ctrl + e`.

# 3. Run the following commands

```bash
acme deploy --prod
```

IP : 134.209.181.178

Password: jfr{_?G,Z+2cLM

MySQL Password : 6e688ffde171aaeaa335f51d8bb77ce46e4ba3bf7f3b752c

sudo apt-get install aspnetcore-runtime-2.2

*** LINUX SERVER SETUP USING A NEWLY CREATED DIGITAL OCEAN LAMP SERVER ***

1. ssh root@ipaddressOfLinuxServer (follow instructions to change password)
2. Set up mysql (password available from welcome message)

mysql -u root -p

CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'Pa$$w0rd';
GRANT ALL PRIVILEGES ON *.* TO 'appuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

1. Install the dotnet runtime (follow instructions from here [https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/runtime-current](https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/runtime-current))
2. Configure Apache

a2enmod proxy proxy_http proxy_html

systemctl restart apache2

1. Configure the virtual host

sudo nano /etc/apache2/sites-available/datingapp.conf

<VirtualHost *:80>
ProxyPreserveHost On
ProxyPass / [http://127.0.0.1:5000/](http://127.0.0.1:5000/)
ProxyPassReverse / [http://127.0.0.1:5000/](http://127.0.0.1:5000/)

ErrorLog /var/log/apache2/datingapp-error.log
CustomLog /var/log/apache2/datingapp-access.log common

</VirtualHost>

1. Enable the site

a2ensite datingapp

--- deploy the published app before going further ---

1. Add the deploy.reloaded extension to VS Code
2. Add a settings.json file in the .vscode folder and add the following:

{
"deploy.reloaded": {
"packages": [
{
"name": "Version 1.0.0",
"description": "Package version 1.0.0",

```
"files": [
                "DatingApp.API/bin/Release/netcoreapp2.2/publish/**"
            ]
        }
    ],

    "targets": [
        {
            "type": "sftp",
            "name": "Linux",
            "description": "SFTP folder",

            "host": "165.22.134.96", "port": 22,
            "user": "root", "password": "yourpassword",

            "dir": "/var/datingapp",
            "mappings": {
                "DatingApp.API/bin/Release/netcoreapp2.2/publish/**": "/"
            }
        }
    ]
}
```

}

1. Publish the dotnet application:

dotnet publish -c Release

1. Deploy the 'package' using the command palette - deploy package
2. Check the files are on the Linux server:

ls /var/datingapp/

1. Set up the kestrel web service

sudo nano /etc/systemd/system/kestrel-web.service

// configuration without environment variables

[Unit]
Description=Kestrel service running on Ubuntu 18.04
[Service]
WorkingDirectory=/var/datingapp
ExecStart=/usr/bin/dotnet /var/datingapp/DatingApp.API.dll
Restart=always
RestartSec=10
SyslogIdentifier=datingapp
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production
[Install]
WantedBy=multi-user.target

// configuration with environment variables

[Unit]
Description=Kestrel service running on Ubuntu 18.04
[Service]
WorkingDirectory=/var/datingapp
ExecStart=/usr/bin/dotnet /var/datingapp/DatingApp.API.dll
Restart=always
RestartSec=10
SyslogIdentifier=datingapp
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment='Cloudinary__CloudName=yourcloudname'
Environment='Cloudinary__ApiSecret=yoursecret'
Environment='Cloudinary__ApiKey=yourapikey'
Environment='TokenKey=super secret key'
[Install]
WantedBy=multi-user.target

sudo systemctl enable kestrel-web.service
sudo systemctl start kestrel-web.service

1. Ensure the server is listening on Port 5000

netstat -ntpl

1. Check the Mysql DB to ensure it is seeded with data:

mysql -u appuser -p
show databases;
use datingapp;
show tables;
select * from users;

1. Browse to app on Linux server IP address.