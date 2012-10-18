library dart_delivert_client;

import "dart:io";

const _CLIENT_FILES = "web/client";
const _ROOT_URL = "/";
const _WELCOME_PAGE = "/index.html";

main(){
  print('Starting....');
  var env = Platform.environment;
  var port = env['PORT'] == null ? 12345 : int.parse(env['PORT']);
  var ip = "0.0.0.0";

  var server = new HttpServer();
  server.defaultRequestHandler = _serveFile; 
  server.listen(ip, port);


  print('Listening for connections on $ip:$port');
}

_hello(HttpRequest request, HttpResponse response){
  response.outputStream..writeString("Hello !!!")
                       ..close();
}

_serveFile(HttpRequest request, HttpResponse response){
  // TODO favicon.ico
  var fileName = request.path == _ROOT_URL ? _WELCOME_PAGE : request.path;
  var file = new File(_CLIENT_FILES.concat(fileName));
  file.exists().then((exist) {
    if(exist){
      file.openInputStream().pipe(response.outputStream);
    } else {
      // TODO page 404
      response.statusCode = HttpStatus.NOT_FOUND;
      response.outputStream.close();        
    }    
  });
}

