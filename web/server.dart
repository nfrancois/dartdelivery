import "dart:io";


main(){
  print('starting....');
  var env = Platform.environment;
  var port = int.parse(env['PORT']);
  var ip = "0.0.0.0";

  var server = new HttpServer();
  server.defaultRequestHandler = _hello; 
  server.listen(ip, port);


  print('Listening for connections on $ip:$port');
}

_hello(HttpRequest request, HttpResponse response){
  response.outputStream..writeString("Hello !!!")
                       ..close();
}
