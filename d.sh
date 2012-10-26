#!/bin/bash
# This command will automatically perform updates, commits to Git.
# also will perform the required cleanup.
#
#
IDP_INSTALL_PATH=
IDP_GIT_COMMIT_MASTER=
IDP_GIT_MASTER=master
IDP_GIT_ORIGIN=origin
JAVA_SRC_DIR=$PWD/src/main/java
JAVA_OUT_DIR=$PWD/out
LICENSE_FILE_NAME=License
#--------------------------------------------------------------------------
#initialize the environment variables.
#IDP_INSTALL_PATH => the rails application installation directory.
#--------------------------------------------------------------------------
initialize(){


    if [ -f "$PWD/pom.xml" ] ;
then
echo "I know what you did last summer!"
     else
echo "WARNING ! "
        echo " This doesn't appear to the top level directory."
     fi

IDP_INSTALL_PATH=$PWD

}
#
#
#
#--------------------------------------------------------------------------
#parse the input parameters.
# Pattern in case statement is explained below.
# a*) The letter a followed by zero or more of any
# *a) The letter a preceded by zero or more of any
#--------------------------------------------------------------------------
parseParameters() {
#integer index=0
if [ $# -lt 1 ]
then
help
exitScript 0
fi
IDP_GIT_COMMIT_MASTER=$2

for item in "$@"
do
case $item in
        --[hH][eE][lL][pP])
            help
            ;;
	--[lL][uU][dD])
	licenseupd
	;;
	('/?')
            help
            ;;
            --[mM][yY])
echo "Howdy $IDP_GIT_MASTER. Enjoy committing local to <master> - Github..."
            mystuff
            ;;
            --[oO][mM][yY])
echo "Howdy $IDP_GIT_ORIGIN. Enjoy committing local to <origin> - Github..."
            origin_stuff
            ;;
            --[uU][pP][dD])
echo "Howdy $IDP_GIT_MASTER.enjoy merging <origin> to local..."
            uptodate
            ;;
            --[fF][iI][nN][iI][sS][hH])
            finish
            ;;
         --[cC][lL][eE][aA][nN])
echo "Cleaning up tmp..."
            clean
            ;;
  --[vV][eE][rR][sS][iI][oO][nN])
version
            ;;
        '--verify')
verify
            ;;
        *)
echo "Unknown option : $item - refer help."
            help	
            ;;
esac
index=$(($index+1))
done
}
#
#
#--------------------------------------------------------------------------
#prints the help to out file.
#--------------------------------------------------------------------------
help(){
    echo "Usage : d.sh [Options]"
    echo "--help   : prints the help message."
    echo "--verify : does a git status."
    echo "--lud    : does a insert of License file into your code."
    echo "--my     : does a add, commit and push of my master."
    echo "--omy    : does a add, commit and push to origin."
    echo "--upd    : does a fetch from origing and merge to my master."
    echo "--finish : does a push of anothers users master to origin"
    echo " (committer only)"
    echo "--clean  : cleans up the temp files."
    
exitScript 0
}
#
#
#--------------------------------------------------------------------------
#Updates the license text in all the source code.
#--------------------------------------------------------------------------
licenseupd(){
if [ ! -f $LICENSE_FILE_NAME ]
then
    echo $LICENSE_FILE_NAME does not exists.
    exitScript 0
fi
echo "========================================================="
printf "%-20s=>\t%s\n" Updating [$LICENSE_FILE_NAME]
echo "========================================================="
echo -n "Do you want to insert [$LICENSE_FILE_NAME] text into your code [y/n]? "
read -n 1 licenseupd
echo
if [[ $licenseupd =~ ^[Yy]$ ]]
then
echo "========================================================="

cd $JAVA_SRC_DIR

if [ -d $JAVA_OUT_DIR ]
then
rm -r $JAVA_OUT_DIR
fi

mkdir $JAVA_OUT_DIR

for i in `find -type d | sed 's/\.//' | grep -v "^$"`; do mkdir $JAVA_OUT_DIR$i; done
for i in `find -name "*.java"`; do cat $IDP_INSTALL_PATH/$LICENSE_FILE_NAME $i > $JAVA_OUT_DIR/$i ; done
fi
   
exitScript 0
}
#--------------------------------------------------------------------------
# verify the installation
# this pretty much dumps the environment variables., java path and arguments
#-------------------------------------------------------------------------
verify(){
echo "========================================================="
printf "%-20s=>\t%s\n" git remote
echo "========================================================="
git remote -v
echo "========================================================="
printf "%-20s=>\t%s\n" git status
echo "========================================================="
git status
echo "========================================================="
exitScript 1
}
#--------------------------------------------------------------------------
# git add all the files,commits to the local repos.
# performs a push to the users master in github.
#-------------------------------------------------------------------------
mystuff(){

echo -n "Do you want to add/commit files [y/n]? "
read -n 1 addcommit
echo

if [[ $addcommit =~ ^[Yy]$ ]]
then
echo "========================================================="
git add .
git commit .
fi
echo "========================================================="
echo -n "Do you want to push to your master [y/n]? "
read -n 1 pmstr
echo
if [[ $pmstr =~ ^[Yy]$ ]]
then
echo "========================================================="
git push master
echo "========================================================="
fi
verify
exitScript 1
}
#--------------------------------------------------------------------------
# git add all the files,commits to the local repos.
# performs a push to the committers origin in github.
#-------------------------------------------------------------------------
origin_stuff(){

echo -n "Do you want to add/commit files [y/n]? "
read -n 1 addcommit
echo

if [[ $addcommit =~ ^[Yy]$ ]]
then
echo "========================================================="
git add .
git commit .
fi
echo "========================================================="
echo -n "Do you want to push to your origin [y/n]? "
read -n 1 pmstr
echo
if [[ $pmstr =~ ^[Yy]$ ]]
then
echo "========================================================="
git push origin
echo "========================================================="
fi
verify
exitScript 1
}
#--------------------------------------------------------------------------
# git add all the files,commits to the local repos.
# performs a push to the users master in github.
#-------------------------------------------------------------------------
uptodate(){
echo -n "Do you want to add/commit files [y/n]? "
read -n 1 addcommit
echo

if [[ $addcommit =~ ^[Yy]$ ]]
then
echo "========================================================="
git add .
git commit .
fi
echo "========================================================="
echo -n "Do you want to rebase from origin [y/n]? "
read -n 1 pmstr
echo
if [[ $pmstr =~ ^[Yy]$ ]]
then
echo "========================================================="
git fetch origin
git merge origin
echo "========================================================="
fi
exitScript 1
}
#--------------------------------------------------------------------------
# git add all the files,commits to the local repos.
# performs a push to the users master in github.
#-------------------------------------------------------------------------
finish(){
if [ -z $IDP_GIT_COMMIT_MASTER ]
then
echo "Missing parameter <master repository name>."
help
exitScript 1
else
echo "Howdy committer.Enjoy merging <$IDP_GIT_COMMIT_MASTER> to origin..."
echo "========================================================="
echo -n "Do you want to add/commit files [y/n]? "
read -n 1 addcommit
echo

if [[ $addcommit =~ ^[Yy]$ ]]
then
echo "========================================================="
git add .
git commit .
fi
echo "========================================================="
echo -n "Do you want to commit $IDP_GIT_COMMIT_MASTER to your origin [y/n]? "
read -n 1 pmstr
echo
if [[ $pmstr =~ ^[Yy]$ ]]
then
echo "========================================================="
git fetch $IDP_GIT_COMMIT_MASTER
git merge $IDP_GIT_COMMIT_MASTER/master
git push -u origin $IDP_GIT_COMMIT_MASTER/master
echo "========================================================="
fi
verify
exitScript 0
fi
}
#
#
#
#
#--------------------------------------------------------------------------
#This command will automatically cleanup the assests and the tmp directory.
#--------------------------------------------------------------------------
clean(){
#
#
clear
mvn clean
exitScript 0
}
#
#
#
#--------------------------------------------------------------------------
#print the version.
#--------------------------------------------------------------------------
version(){
echo "Nothing to show as version now."
exitScript 0
}
#
#
#
exitScript(){
exit $@
}
#
#
#
#--------------------------------------------------------------------------
# main entry
#--------------------------------------------------------------------------
initialize
#parse parameters
parseParameters "$@"
