#!/usr/bin/env python

import cgitb
import cgi

print "Content-Type: text/html"     # HTML is following
print                               # blank line, end of headers

cgitb.enable(display=0)

import time
import os
import glob

www = "/home/marsj/public_html/tmp/omedit"

url = "https://dev.openmodelica.org/~marsj/tmp/omedit/"
prefix = time.strftime("%Y-%m-%d_%H:%M:%S")

form = cgi.FieldStorage()
commands = form["omeditcommands.log"]
omc_out = form["openmodelica.omc.output.OMEdit"]

outcommands = open("%s/%s-omeditcommands.log" % (www,prefix),"w")
outcommands.write(commands.file.read())
outcommands = open("%s/%s-openmodelica.omc.output.OMEdit" % (www,prefix),"w")
outcommands.write(omc_out.file.read())
files = [
  url+prefix+"-omeditcommands.log",
  url+prefix+"-openmodelica.omc.output.OMEdit",
]

try:
  omedit_stack = form["openmodelica.stacktrace.OMEdit"]
  outcommands = open("%s/%s-openmodelica.stacktrace.OMEdit" % (www,prefix),"w")
  outcommands.write(omedit_stack.file.read())
  files += [url+prefix+"-openmodelica.stacktrace.OMEdit"]
except:
  pass
print "Upload succeeded!"

import smtplib
from email.mime.text import MIMEText
msg = MIMEText("OMEdit crash; see the following files:\n" + "\n".join(files))
msg['Subject'] = "OMEdit crash report"
me = "omedit@dev.openmodelica.org"
you = "martin.sjolund@liu.se"
msg['From'] = me
msg['To'] = you

s = smtplib.SMTP('openmodelica.org')
s.sendmail(me, [you], msg.as_string())
s.quit()

def cleanFiles(globName):
  for f in glob.glob(globName):
    # >14 days old?
    old_age = time.time() - os.path.getmtime(f) > (7 * 24 * 60 * 60)
    if old_age:
      os.unlink(f)

cleanFiles("/home/marsj/www/*")
