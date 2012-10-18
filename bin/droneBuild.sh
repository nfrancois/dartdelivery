# Syncho
echo 'Syncho...'
git config --global user.email "drone.io@haha.ha"
git config --global user.name "DroneIO"
git remote add herokuSync git@heroku.com:dartdelivery.git
git remote -v
git fetch herokuSync
git merge herokuSync/master
git log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative

# Clean
echo 'Clean...'
if [ -f packages ]; then
  rm -rf packages
fi
if [ -f web/client/public/client.dart.* ]; then
  rm web/client/public/client.dart.*
fi

# Build
echo 'Build...'
pub install
bin/runTests.sh
bin/buildjs.sh

# Add compiled files to deploy
echo 'Prepare to deploy...'
if [ -f .gitignore ]; then
  rm .gitignore
fi
STATUS=`git status -s`
if [ "$STATUS" != "" ] ; then
echo 'commit'
  git add -A
  git commit -m "compiled files"
fi
