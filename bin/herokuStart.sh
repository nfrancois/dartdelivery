#!/bin/sh


echo 'Compile dart2js'
bin/buildjs.sh

echo 'start server'
dart web/server.dart
