const http = require('http');
const httpProxy = require('http-proxy');

const proxy = httpProxy.createProxyServer({});
const server = http.createServer(function(req, res) {
  console.log('Request', req.method, req.url);
  proxy.web(req, res, { target: `${req.protocol}://${req.hostname}` });
});

server.listen(
    {
        host: "0.0.0.0",
        port: 3128,
    },
    () => {
        console.log("Server proxy listening on 0.0.0.0:3128");
    }
);