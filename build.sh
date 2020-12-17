#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source VERSIONS
mvnparam=$1

function build_oi(){
 package_name=$1
 package_version=$2
 package=${package_name}_$package_version
 mkdir -p deb/$package/usr/lib
 mkdir -p deb/$package/usr/bin
 mkdir -p deb/$package/usr/share/man/man1/
 mvn package -D$mvnparam
 sudo cp src/main/resources/$package_name deb/$package/usr/bin
 sudo cp target/$package_name.jar deb/$package/usr/lib
}

function build(){
 package_name=$1
 package_version=$2
 package=${package_name}_$package_version

 if [ -d $scriptdir/man/$package_name ]
 then
   cd $scriptdir/man/$package_name
   asciidoctor -b manpage man.adoc
   cd -
   sudo cp $scriptdir/man/$package_name/$package_name.1 deb/$package/usr/share/man/man1/
 fi  
 dpkg-deb --build deb/$package
}

build oi $oi_version
build lscsv $lscsv_version
build libprocname $libprocname_version
