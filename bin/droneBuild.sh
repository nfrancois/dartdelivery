# Syncho
echo 'Syncho...
git config --global user.email "drone.io@haha.ha"
git config --global user.name "DroneIO"
git remote add herokuSync git@heroku.com:dartdelivery.git
git remote -v
git fetch herokuSync
git rebase herokuSync/master

# Clean
echo 'Clean...'
if [ -f packages ]; then
  rm -rf packages
fi
if [ -f packages ]; then
  rm web/client/public/client.dart.js
fi

# Build
echo 'Build...'
pub install
bin/runTests.sh
bin/buildjs.sh

# Add compiled files to deploy
echo 'Prepare to deploy...'
git log HEAD..origin/master
if [ -f .gitignore ]; then
  rm .gitignore
fi
git status -s
git add -A
git commit -m "compiled files"