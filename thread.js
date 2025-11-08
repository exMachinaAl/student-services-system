const { fork } = require("child_process");

const child = fork("src/server.js");
child.send("Halo dari parent");
child.on("message", (msg) => console.log("Pesan dari child:", msg));
