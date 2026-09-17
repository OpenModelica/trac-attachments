import requests

files = {}
files['omeditcommands.log'] = open('/tmp/OpenModelica_martin/OMEdit/omeditcommands.log', 'rb')
files['openmodelica.omc.output.OMEdit'] = open('/tmp/OpenModelica_martin/OMEdit/openmodelica.omc.output.OMEdit', 'rb')
try:
  files['openmodelica.stacktrace.OMEdit'] = open('/tmp/OpenModelica_martin/OMEdit/openmodelica.stacktrace.OMEdit', 'rb')
except:
  pass
r = requests.post('https://dev.openmodelica.org/~marsj/cgi-bin/a.py', files=files)

print r.text
