library dart_delivert_client;

import "dart:io";

const _CLIENT_FILES = "web/client/public";
const _ROOT_URL = "/";
const _WELCOME_PAGE = "/index.html";
const _HTML_EXTENSION = ".html";
const _ERRORS_FILES= "web/client/errors/";

main(){
  print('Starting....');
  var env = Platform.environment;
  var port = env['PORT'] == null ? 12345 : int.parse(env['PORT']);
  var ip = "0.0.0.0";

  var server = new HttpServer();
  server.defaultRequestHandler = _serveHandler; 
  server.listen(ip, port);


  print('Listening for connections on $ip:$port');
}

_hello(HttpRequest request, HttpResponse response){
  response.outputStream..writeString("Hello !!!")
                       ..close();
}

_serveHandler(HttpRequest request, HttpResponse response){
  var fileName = request.path == _ROOT_URL ? _WELCOME_PAGE : request.path;
  var file = new File(_CLIENT_FILES.concat(fileName));
  file.exists().then((exist) {
    if(exist){
      _serveFile(file, response.outputStream);
    } else {
      response.statusCode = HttpStatus.NOT_FOUND;
      if(!fileName.contains(".") || fileName.endsWith(_HTML_EXTENSION)){
        _errorPage(response.statusCode, response.outputStream);
      } else {
        print("File not found $fileName");
        response.outputStream.close(); 
      }
    }    
  });
}

_errorPage(int error, OutputStream outputStream){
  File errorPage = new File(_ERRORS_FILES.concat(error.toString()).concat(_HTML_EXTENSION));
  _serveFile(errorPage, outputStream);
}

_serveFile(File file, OutputStream outputStream){
  file.openInputStream().pipe(outputStream);  
}

