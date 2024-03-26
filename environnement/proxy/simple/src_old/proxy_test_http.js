
// Simple HTTP server just for testing

var assert  = require('assert'),
    dns     = require('dns'),
    http    = require('http'),
    util    = require('util');

const url = require('url');

function ltrc() { console.log.apply(this, arguments); }

function displayHeaders(req) {
    var headers = req.headers;
    var keys = Object.keys(headers);
    ltrc('\nHTTP request headers:  (%j)', keys.length );
    for( var idx=0, l=keys.length; idx < l ; idx++) {
      var key = keys[idx];
      ltrc('    %j    %j', key, headers[key]);
    }
}

//-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -

var our_port  = 3128;
var our_host  = '0.0.0.0';


//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Create a server just to dump information about requests

function onRequest(sreq, sres) {

  displayHeaders(sreq);

  /*
  var socket = req.connection;

  var host_bound_addr = socket.address();
  ltrc('\nHTTP request to   %j', host_bound_addr );
  var clnt_bound_addr = { 'address': socket.remoteAddress,
                          'port':    socket.remotePort };
  ltrc('HTTP request from %j', clnt_bound_addr );
  */

  const { pathname } = url.parse(sreq.url);
  const opts = {
    host: sreq.connection.remoteAddress,
    port: sreq.port,
    path: pathname,
    method: sreq.method,
    headers: sreq.headers,
  }

  const creq = http.request(opts, (cres) => {
    // passthrough status code and headers
    sres.writeHead(cres.statusCode, cres.headers);
    cres.pipe(sres);
  });

  sreq.pipe(creq);



  //res.writeHead(200, {'Content-Type': 'text/plain'});
  //res.end('okay');
}

var hsrvr = http.createServer(onRequest);

function onListening() {
  var srvr  = this;
  var host_bound_addr = srvr.address();
  ltrc('HTTP server is listening on %j', host_bound_addr );
}

hsrvr.listen(our_port, our_host, onListening);

