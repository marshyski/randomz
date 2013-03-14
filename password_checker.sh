#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## PASSWORD CHECK SCRIPT (GREAT FOR NIS)  ##
## 03MAR2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################


MIN_LEN="14"

read -p "Username: " username

while true; do
   
   ANSWER="N"
   
   read -s -p "Password: " PASS
   echo ""
   read -s -p "Confirm Password: " PASS2
   
   if [[ $PASS != $PASS2 ]]; then
      echo ""
      echo ""
      echo "Passwords do not match, try again."
      echo ""
   fi
   
   if [[ -f /usr/share/dict/words ]]; then
      if [[ `grep -i $PASS /usr/share/dict/words` != "" ]]; then
         echo "Password contains common dictonary word."
         ANSWER="Y"
      fi
   fi
   
   if [[ `echo $PASS | grep -i "$username"` != "" ]]; then
      echo "Password contains username."
      ANSWER="Y"
   fi
   
   if [[ `echo $PASS | wc -L` -lt "$MIN_LEN" ]]; then
      echo "Password less then $MIN_LEN characters long."
      ANSWER="Y"
   fi
   
   if [[ $PASS != *[[:digit:]]* ]]; then
      echo "Password should contain at least one digit."
      ANSWER="Y"
   fi
   
   if [[ $PASS != *[[:upper:]]* ]]; then
      echo "Password should contain at least one uppercase letter."
      ANSWER="Y"
   fi
   
   if [[ $PASS != *[[:lower:]]* ]]; then
      echo "Password should contain at least one lowercase letter."
      ANSWER="Y"
   fi
   
   if [[ $PASS != *[[:punct:]]* ]]; then
      echo "Password should contain at least one special character."
      ANSWER="Y"
   fi
   
   if [[ $ANSWER = "N" ]]; then
      break
   fi
   
   echo ""
   
done

#echo "$PASS" | passwd --stdin $USER

echo ""
