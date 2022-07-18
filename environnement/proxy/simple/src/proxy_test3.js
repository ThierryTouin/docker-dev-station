
// Simple HTTP server just for testing

var assert  = require('assert'),
    dns     = require('dns'),
    http    = require('http'),
    util    = require('util');


function ltrc() { console.log.apply(this, arguments); }


//-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -

var our_port  = 3128;
var our_host  = '0.0.0.0';


//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Create a server just to dump information about requests

function onRequest(req, res) {
  var socket = req.connection;

  var host_bound_addr = socket.address();
  ltrc('\nHTTP request to   %j', host_bound_addr );
  var clnt_bound_addr = { 'address': socket.remoteAddress,
                          'port':    socket.remotePort };
  ltrc('HTTP request from %j', clnt_bound_addr );

  var headers = req.headers;
  var keys = Object.keys(headers);
  ltrc('\nHTTP request headers:  (%j)', keys.length );
  for( var idx=0, l=keys.length; idx < l ; idx++) {
    var key = keys[idx];
    ltrc('    %j    %j', key, headers[key]);
  }

  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('okay');
}

var hsrvr = http.createServer(onRequest);

function onListening() {
  var srvr  = this;
  var host_bound_addr = srvr.address();
  ltrc('HTTP server is listening on %j', host_bound_addr );
}

hsrvr.listen(our_port, our_host, onListening);

// vim:ft=javascript:ts=2:sw=2:et:is:hls:ss=10:tw=160: