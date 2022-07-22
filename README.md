# Introduction

Open-source helpdesk ticketing system

No more confusing interfaces and operations! With Tickotty, you can quickly deal with support requests by adding your own agents. Thanks to its easy and user-friendly interface, navigating through its features is effortless.

[![AngularJS](https://img.shields.io/badge/php-%3E%3D_7.4-8892BF.svg)](#) [![AngularJS](https://img.shields.io/badge/mysql-%3E%3D_5.7-F29111.svg)](#) 
[![AngularJS](https://img.shields.io/badge/AngularJS-E23237?style=flat&logo=angularjs&logoColor=white)](#) 
[![GitHub issues](https://img.shields.io/github/issues/Prokfantasmist/Tickotty)](https://github.com/Prokfantasmist/Tickotty/issues) 
[![GitHub forks](https://img.shields.io/github/forks/Prokfantasmist/Tickotty)](https://github.com/Prokfantasmist/Tickotty/network) 
[![GitHub stars](https://img.shields.io/github/stars/Prokfantasmist/Tickotty)](https://github.com/Prokfantasmist/Tickotty/stargazers) 
[![GitHub license](https://img.shields.io/github/license/Prokfantasmist/Tickotty)](https://github.com/Prokfantasmist/Tickotty/blob/main/LICENSE) 
[![Support me on Patreon](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3Dluceat%26type%3Dpatrons&style=flat)](https://patreon.com/luceat)

* * *

![](http://luceat.solutions/trivia/tickotty-main-intro.jpg)

* * *

# Requirements
In most servers, these extensions are enabled by default, but you should check with your hosting provider.
*   PHP 7.4+
*   MYSQL 5.7+

*   mod\_rewrite Apache
*   MBString Extension
*   GD Extension
*   MYSQLi Extension
*   PDO Extension
*   Zip Extension
*   CURL Extension

# Installation
Tickotty - Help Desk has an easy setup, first, create a database, then go to your domain name where you uploaded the files it will be redirected install page automatically.

## Hosting Installation
### cPanel
#### First Step
First of all, please upload the application files to the folder where you want to install the application with the cPanel file manager.
#### To create a MySQL database:
*   Log in to cPanel.
*   Click MySQL Databases under Databases in cPanel.
*   Type your database name.
*   When ready, click Create Database.
#### Creating a database user
*   Click MySQL Databases under Databases in cPanel.
*   Under MySQL Users > Add New User, enter the MySQL username in the Username text box.
*   In the Password text box, enter the user password.
*   In the Password (Again) text box, retype the user password.
*   When ready, click Create User.
#### Adding user to a database
*   Click MySQL Databases under Databases in cPanel.
*   Under Add User to Database, select the user that you want to add from the User drop-down menu.
*   In the Database drop-down menu, select the database.
*   Click Add.
*   Select the privileges you want to grant the user, or click ALL PRIVILEGES to grant the user all permissions to the database.
*   When ready, click Make Changes.
#### If the creating database and adding users to the database are completed.
Now you can go to the installation screen via the folder where the files are uploaded ([http://example.com/yours](#)), the page will automatically redirect you to the setup screen.
#### If it does not automatically switch to the installation screen
All you have to do is go to the link [http://example.com/yours/service/install](#)
#### On Installation Screen
*   Make sure all the dependencies are installed.
*   Click “Next” only if you see “Green Tick” beside all the dependencies.
*   Type your database credentials
*   Click on Install.
Congratulations, the installation is complete!

## XAMP Installation
Few changes we need to do in **XAMPP** default installation.

**1\. Change the .htaccess**

RewriteRule ^(.\*)$ index.php?/$1 \[L,QSA\]

to

RewriteRule ^(.\*)$ /yourfolder/index.php?/$1 \[L,QSA\]

**2\. Navigate to localhost/yourfolder/install**

## MAMP Installation

Few changes we need to do in **MAMP** default installation.

**1\. Change the .htaccess**

RewriteRule ^(.\*)$ index.php?/$1 \[L,QSA\]

to

RewriteRule ^(.\*)$ /yourfolder/index.php?/$1 \[L,QSA\]

**2\. Navigate to localhost/yourfolder/install**

# Errors

## 404 Not Found
If you are getting 404 Not Found error after your install, this means that you need to adjust the main .htaccess for Tickotty

**Change the .htaccess with**

RewriteEngine on  
RewriteCond $1 !^(index.php|resources|robots.txt)  
RewriteCond %{REQUEST\_FILENAME} !-f  
RewriteCond %{REQUEST\_FILENAME} !-d  
RewriteRule ^(.\*)$ index.php?/$1 \[L,QSA\]  

## 500 Internal Server

If you are getting 500 Internal Server error after your install, this means that you need to adjust the main .htaccess for Tickotty

#### Info

If you getting this error try to change your PHP version to 7.4 or higher

**Change the .htaccess with**

RewriteEngine on  
RewriteCond $1 !^(index\\.php|resources|robots\\.txt)  
RewriteCond %{REQUEST\_FILENAME} !-f  
RewriteCond %{REQUEST\_FILENAME} !-d  
RewriteRule ^(.\*)$ subfoldername/index.php?/$1 \[L,QSA\]  
AddDefaultCharset utf-8  

# Features

## Dashboard
You can track weekly statistics of open, assigned, answered, or closed tickets and the resolving percentages from the dashboard.
## Clients
To create tickets, clients must register. All registered users are added directly to the "client" list if you have problems with a specific client, you can prevent them from logging into the application.
## Tickets 
Registered clients can easily add and follow on their support requests, agents who review support requests can filter requests by status, priority, assigned staff, or department.
## Reports 
This feature supplies information about the statistics of the average response and resolution times of all tickets, as well as taking reports about tickets filtered by assigned staff or other characteristics.
## Service Level Policy 
You & your client can agree on a mutual time about how much time period the requests will be answered or resolved. When you define & assign this parameter to your client, you can see the details of SLA in the support tickets, this data is constantly checked with the cron jobs and a notification is sent for the violated support tickets.
## Staff 
You or your clients can add staff or workfellows to the application. You can also authorize a staff member and restrict any user from accessing the features. Staff can change their working hours.
## Knowledge Base 
Thanks to the knowledge base, your clients can find the answers they seek without the need to create a support request. You can add new articles to the knowledge base for clients who want to reach the solution quickly.
## Custom Fields 
You can use custom fields to get additional information from customers who submit a ticket. These fields can be managed and rearranged by you. Also, they can be created conditionally if their definition depends on other fields.

* * *

# Demo

[![](http://luceat.solutions/trivia/tickotty-visit-demo.png)](http://luceat.solutions/auxilium) [![](http://luceat.solutions/trivia/tickotty-documentation.png)](http://luceat.solutions/tickotty/documentation)

|Role|User|Password|
|:--- |:---- |:----|
|Admin|admin@luceat.solutions|admin|
|Staff|harper@luceat.solutions|demo|
|Client|juniper@luceat.solutions|demo|
