const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const https = require('https');

const app = express();
// const API_TARGET = 'https://localhost:8443';
const API_TARGET = 'https://localhost:3000';
const PORT = 3001;
const httpsAgent = new https.Agent({ rejectUnauthorized: false });

const proxyOptions = {
  target: API_TARGET,
  changeOrigin: true,
  secure: false,
  agent: httpsAgent,
  ws: true,
  logLevel: 'warn',
  onProxyRes(proxyRes, req, res) {
    // Rewrite Location header (redirect) supaya kembali ke proxy host
    const loc = proxyRes.headers['location'];
    if (loc) {
      proxyRes.headers['location'] = loc.replace(API_TARGET, `${req.protocol}://${req.headers.host}`);
    }

    // Rewrite Set-Cookie untuk development:
    const setCookie = proxyRes.headers['set-cookie'];
    if (setCookie) {
      proxyRes.headers['set-cookie'] = setCookie.map(cookie => {
        // 1) Hapus Secure (jika kamu pakai http proxy dev)
        cookie = cookie.replace(/;\s*Secure/gi, '');
        // 2) Hapus Domain supaya jadi host-only (proxy host)
        cookie = cookie.replace(/;\s*Domain=[^;]+/i, '');
        // 3) Optionally tweak SameSite for dev
        cookie = cookie.replace(/;\s*SameSite=None/gi, '; SameSite=Lax');
        return cookie;
      });
    }
  },
  onError(err, req, res) {
    if (!res.headersSent) res.writeHead(502, {'Content-Type':'application/json'});
    res.end(JSON.stringify({ error: 'proxy error' }));
  }
};

app.use('/', createProxyMiddleware(proxyOptions));
// app.use('/api', createProxyMiddleware(proxyOptions));
app.listen(PORT, () => console.log(`proxy listening http://localhost:${PORT}`));
