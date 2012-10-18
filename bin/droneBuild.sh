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
git status -s
if [ -f .gitignore ]; then
  rm .gitignore
fi
git add -A
git commit -m "compiled files"