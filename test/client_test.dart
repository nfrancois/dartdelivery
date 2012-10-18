library dart_delivert_client_test;

import 'package:unittest/unittest.dart';
import '../web/client/client_core.dart';
  
main(){
  print("Running tests...");
  test("Message titre", test_title_message);
}

test_title_message(){
  expect("Dart Delivery", Messages.title);
}
  
