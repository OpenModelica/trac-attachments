#~/bin/bash
set -e
export OPENMODELICALIBRARY=`pwd`:/usr/lib/omlibrary
python3 -i simulateCDL.py
rm -f Buildings.* 2&> /dev/null
