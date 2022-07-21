// Import of net module
const net = require("net");
const server = net.createServer();
const parseHeaders = require('./lib/parseHeaders');
const displayHeaders = require('./lib/displayHeaders');


function ltrc() { console.log.apply(this, arguments); }

function serverDetails(server,socket) {

    console.log('---------server details -----------------');

    var address = server.address();
    var port = address.port;
    var family = address.family;
    var ipaddr = address.address;
    console.log('Server is listening at port' + port);
    console.log('Server ip :' + ipaddr);
    console.log('Server is IP4/IP6 : ' + family);
    
    var lport = socket.localPort;
    var laddr = socket.localAddress;
    console.log('Server is listening at LOCAL port' + lport);
    console.log('Server LOCAL ip :' + laddr);
    
    console.log('------------remote client info --------------');
    
    var rport = socket.remotePort;
    var raddr = socket.remoteAddress;
    var rfamily = socket.remoteFamily;
    
    console.log('REMOTE Socket is listening at port' + rport);
    console.log('REMOTE Socket ip :' + raddr);
    console.log('REMOTE Socket is IP4/IP6 : ' + rfamily);
    
    console.log('--------------------------------------------')

}

function socketDoCall(clientToProxySocket) {

    clientToProxySocket.once("data", (data) => {
        let isTLSConnection = data.toString().indexOf("CONNECT") !== -1;


        console.log("isTLSConnection:" + isTLSConnection);

        let serverPort = 80;
        let serverAddress;
        console.log(data.toString());
        if (isTLSConnection) {
            serverPort = 443;
            serverAddress = data
                .toString()
                .split("CONNECT")[1]
                .split(" ")[1]
                .split(":")[0];
        } else {
            serverAddress = data.toString().split("Host: ")[1].split("\r\n")[0];
        }
        console.log(serverAddress);

        // Creating a connection from proxy to destination server
        let proxyToServerSocket = net.createConnection(
            {
                host: serverAddress,
                port: serverPort,
            },
            () => {
                console.log("Proxy to server set up");
            }
        );

        const headers = parseHeaders(data);
        displayHeaders(headers);

        if (isTLSConnection) {
            clientToProxySocket.write("HTTP/1.1 200 OK\r\n\r\n");
        } else {
            proxyToServerSocket.write(data);
        }

        clientToProxySocket.pipe(proxyToServerSocket);
        proxyToServerSocket.pipe(clientToProxySocket);

        proxyToServerSocket.on("error", (err) => {
            console.log("Proxy to server error");
            console.log(err);
        });

        clientToProxySocket.on("error", (err) => {
            console.log("Client to proxy error");
            console.log(err)
        });
    });

}



server.on("connection", (clientToProxySocket) => {
    console.log("\n\n\n============================================================================");
    console.log("Client connected to proxy");

    serverDetails(server,clientToProxySocket);

    server.getConnections(function(error,count) {
        console.log('Number of concurrent connections to the server : ' + count);
    });
  
    
  
    clientToProxySocket.setTimeout(800000,function() {
        console.log('Socket timed out');
    });

    socketDoCall(clientToProxySocket);


});

server.on("error", (err) => {
    console.log("Some internal server error occurred");
    console.log(err);
});

server.on("close", () => {
    console.log("Client disconnected");
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
