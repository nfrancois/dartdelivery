library dart_delivert_client;

import 'dart:html';

import 'client_core.dart';

main(){
  query("h1")..addText(Messages.title)
             ..addText(" !!!");
}

