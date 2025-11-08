const express = require("express");
const router = express.Router();
const db = require("../utility/mysql");

router.post("/send", async (req, res) => {
  const { sender_id, receiver_id, message } = req.body;
});