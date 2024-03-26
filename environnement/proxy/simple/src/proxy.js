const express = require('express');
const morgan = require("morgan");
const { createProxyMiddleware } = require('http-proxy-middleware');

// Create Express Server
const app = express();

// Configuration
const PORT = 3000;
const HOST = "localhost";
const API_SERVICE_URL = "https://httpbin.org";

/**
 * Configure proxy middleware
 */
const myProxy = createProxyMiddleware({
    target: API_SERVICE_URL,
    changeOrigin: true, // for vhosted sites, changes host header to match to target's host
    logger: console,
  });

// Logging
app.use(morgan('dev'));


/**
 * Add the proxy to express
 */
app.use('/info', myProxy);

// Start Proxy
app.listen(PORT, HOST, () => {
    console.log(`Starting Proxy at ${HOST}:${PORT}`);
});


process.on('SIGINT', () => server.close());
process.on('SIGTERM', () => server.close());