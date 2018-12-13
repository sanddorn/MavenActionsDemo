#! /bin/sh

echo ${SECRET}

if [ -z ${SECRET} ]; then
  echo secret is empty
fi

if [ "${SECRET}" = "Secret" ]; then
  echo SECRET was decrypted right
fi
