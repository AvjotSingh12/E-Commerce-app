const express = require("express");
const router = express.Router();
const {
  createUser,
  getUser,
  loginUser
} = require("../controllers/userController");

router.post("/", createUser); // POST /api/users
router.get("/:id", getUser);  // GET /api/users/:id
router.post("/login", loginUser); // ✅ POST /api/users/login

module.exports = router;
