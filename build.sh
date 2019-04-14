# Password for user name is the first argument
if [ -z "$1" ]; then 
    echo "No password given"
    exit -1
fi 

docker build . \
    -t devbase \
    --build-arg USER_PWD=$1