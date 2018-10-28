echo Running Packages.sh 
echo adding required packages and repos

# add opencontrail extra packages repo
apt-add-repository -y ppa:opencontrail/ppa
apt-get update -yqq

# dev tools
apt-get install -yqq --force-yes autoconf automake bison debhelper flex libcurl4-openssl-dev libexpat-dev libgettextpo0 libprotobuf-dev libtool libxml2-utils make protobuf-compiler python-all python-dev python-lxml python-setuptools python-sphinx ruby-ronn scons unzip vim-common libsnmp-python libipfix librdkafka-dev librdkafka1 git-core phablet-tools

# cassandra direct downloads
wget --quiet http://downloads.datastax.com/cpp-driver/ubuntu/14.04/v2.2.0/cassandra-cpp-driver_2.2.0-1_amd64.deb
wget --quiet http://downloads.datastax.com/cpp-driver/ubuntu/14.04/v2.2.0/cassandra-cpp-driver-dev_2.2.0-1_amd64.deb
wget --quiet http://downloads.datastax.com/cpp-driver/ubuntu/14.04/dependencies/libuv/v1.7.5/libuv_1.7.5-1_amd64.deb
dpkg -i libuv_1.7.5-1_amd64.deb cassandra-cpp-driver_2.2.0-1_amd64.deb cassandra-cpp-driver-dev_2.2.0-1_amd64.deb 
rm -f libuv_1.7.5-1_amd64.deb cassandra-cpp-driver_2.2.0-1_amd64.deb cassandra-cpp-driver-dev_2.2.0-1_amd64.deb

# zookeeper
apt-get install --force-yes -yqq libzookeeper-mt-dev

# dev libraries
apt-get install --force-yes -yqq libboost-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev libboost-program-options-dev libboost-python-dev libboost-regex-dev libboost-system-dev libboost-thread-dev libcurl4-openssl-dev google-mock libgoogle-perftools-dev liblog4cplus-dev libtbb-dev libhttp-parser-dev libxml2-dev libicu-dev

# missing deps fix build errors
apt-get install --force-yes -yqq libipfix-dev nodejs module-assistant

# javahelper fix
apt-get install --force-yes -yqq default-jdk libcommons-codec-java libhttpcore-java liblog4j1.2-java ant javahelper

# added due to libpcap failing to build june 2016 
#sudo apt-get install --force-yes -yqq libnl-3-dev
#sudo apt-get install --force-yes -yqq libnl-dev

