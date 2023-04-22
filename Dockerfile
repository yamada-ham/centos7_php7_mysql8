FROM centos:7

RUN yum update -y && \
    yum install -y httpd

# Apache自動起動
RUN systemctl enable httpd.service
    
# PHP  
RUN yum install -y epel-release
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum -y install --enablerepo=remi,epel,remi-php74 php php-mysqlnd php-mbstring php-gd php-xml php-xmlrpc php-pecl-mcrypt php-fpm php-opcache php-apcu php-pear php-pdo php-zip php-unzip php-pecl-zip phpMyAdmin

RUN yum -y install https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm && \
    yum -y install mysql-community-server

# MySQL 自動起動
RUN systemctl enable mysqld

# RUN yum -y install mod_ssl && \
    # yum -y install firewalld && \
    # yum -y install certbot python2-certbot-apache

# composer 導入
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# RUN yum -y install git

# node.js 導入
# RUN curl -fsSL https://rpm.nodesource.com/setup_16.x
# RUN yum install -y https://rpm.nodesource.com/pub_14.x/el/9/x86_64/nodesource-release-el9-1.noarch.rpm
RUN yum install -y https://rpm.nodesource.com/pub_16.x/el/9/x86_64/nodesource-release-el9-1.noarch.rpm

# lsof は、サーバーで特定のポート番号を待ち受けているかどうか、指定ファイルは誰が読み込んでいるのかを調べる
RUN yum install -y nodejs \
    vim \
    lsof \
    redis

# redis自動起動
RUN systemctl enable redis

# グローバル にgulpを導入
# RUN npm install gulp gulp-cli -g

# ホストで用意した設定ファイルを反映
# COPY ./copy/httpd.conf /etc/httpd/conf/httpd.conf
# COPY ./copy/v_host.conf /etc/httpd/conf.d/v_host.conf
# COPY ./copy/php.ini /etc/php.ini
# COPY ./copy/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf

# ディレクトリの所有者、グループを変更する。
# RUN chown apache:apache /var/www/html/php_error.log

# UTF-8を使えるようにして、日本語を打てるようにする
ENV LC_ALL en_US.UTF-8

#公開ポート番号
EXPOSE 80