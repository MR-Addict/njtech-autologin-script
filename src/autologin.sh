#! /bin/bash

username="your_username"
password="your_password"
channelshow="中国电信&channel=@telecom"
#channelshow="中国移动&channel=@cmcc"

posturl="https://u.njtech.edu.cn"
geturl="https://i.njtech.edu.cn"
captchaapiurl="http://192.168.1.2:45547"

if ping -w 1 -c 1 baidu.com > /dev/null 2>&1; then
  echo "[WARN] $(date) WiFi already connected!" && exit
elif ping -w 1 -c 1 njtech.edu.cn > /dev/null 2>&1; then
  echo "[INFO] $(date) Execute autologin script..."
else
  echo "[WARN] $(date) Cannot access Njtech-Home!"
  echo "[FAIL] $(date) Cannot access Njtech-Home!" >> log.txt && exit
fi

# Store data in login_get_html.html and login_cookie.txt
echo "[INFO] $(date) Fetching data from remote host..."
curl -skL $geturl -c login_cookie.txt -o login_get_html.html

useragent="User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36 Edg/99.0.1150.55"

lt=$(cat login_get_html.html|grep -o -E 'LT-.{37}'|head -1|tail -c 43)
execution=$(cat login_get_html.html|grep -o -E 'name="execution" value=".{4}'|head -1|tail -c 5)
insert_cookie=$(grep "insert_cookie" login_cookie.txt|awk '{print $7}')
JSESSIONID=$(grep "JSESSIONID" login_cookie.txt|awk '{print $7}'|head -1)
posturl=$posturl$(grep "action" login_get_html.html | awk -F"\"" '{print $6}'|head -1)
cookie="Cookie: JSESSIONID="$JSESSIONID"; insert_cookie="$insert_cookie

curl -skL https://u.njtech.edu.cn/cas/captcha.jpg -H "$cookie" -o captcha.jpg
captcha=$(curl -skL $captchaapiurl -F captcha=@captcha.jpg | sed -E 's/.*"message":"?([^,"]*)"?.*/\1/')

form_data="username="$username"&password="$password"&captcha="$captcha"&channelshow="$channelshow"&lt="$lt"&execution="$execution"&_eventId=submit&login=登录"

# post data
echo "[INFO] $(date) Post data to remote host..."
curl -skL -X POST "$posturl" -H "$useragent" -H "$cookie" -d "$form_data" -o login_post_html.html

# check wheather login succeed
sleep 1
if ping -w 1 -c 1 baidu.com > /dev/null 2>&1; then
  echo "[INFO] $(date) Autologin Succeeded!"
  echo "[DONE] $(date) Autologin Succeeded!" >> log.txt
else
  echo "[WARN] $(date) Autologin Failed!"
  echo "[FAIL] $(date) Autologin Failed!" >> log.txt
fi

rm login_*
rm captcha.jpg