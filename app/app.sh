sh '''
  chmod +x app/app.sh tests/test.sh
  ./app/app.sh
'''

#!/bin/bash
echo "Application running on Jim $(hostname)"
sleep 3
