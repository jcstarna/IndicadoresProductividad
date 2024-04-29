#!/bin/sh

PRGDIR=`dirname "$0"`

if java -version > /dev/null 2>&1
then 
 
# -- Prepare CLASSPATH -------------------------------------------------------
LOCALCLASSPATH=$CLASSPATH:$PRGDIR/../config
for i in $PRGDIR/../lib/*.jar $PRGDIR/../drivers/*.jar
do
   LOCALCLASSPATH=$LOCALCLASSPATH:"$i"
done

# -- Invocation to client ------------------------------------------------------------
java -cp $LOCALCLASSPATH ar.com.controlarg.tableroscostura.App -Dlog4j2.contextSelector=org.apache.logging.log4j.core.async.AsyncLoggerContextSelector $@

else 
  echo "Java Virtual Machine not found, please add JRE's bin directory to PATH environment variable"
fi
