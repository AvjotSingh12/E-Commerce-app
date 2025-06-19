// controllers/userController.js

const { db } = require("../config/firebase");

const createUser = async (req, res) => {
  try {
    const { name, email } = req.body;

    if (!name || !email) {
      return res.status(400).json({ error: "Name and email are required" });
    }

    const newUserRef = db.collection("users").doc(); // generate unique ID
    const userData = {
      id: newUserRef.id,
      name,
      email,
      createdAt: new Date().toISOString(),
    };

    await newUserRef.set(userData);
    res.status(201).json(userData);
  } catch (error) {
    console.error("Error creating user:", error);
    res.status(500).json({ error: "Failed to create user" });
  }
};

const getUser = async (req, res) => {
  try {
    const userId = req.params.id;
    const userDoc = await db.collection("users").doc(userId).get();

    if (!userDoc.exists) {
      return res.status(404).json({ error: "User not found" });
    }

    res.status(200).json(userDoc.data());
  } catch (error) {
    console.error("Error fetching user:", error);
    res.status(500).json({ error: "Failed to fetch user" });
  }
};

// ✅ New: Login function (find user by email)
const loginUser = async (req, res) => {
  try {
    const { email } = req.body;

    if (!email) {
      return res.status(400).json({ error: "Email is required" });
    }

    const usersRef = db.collection("users");
    const snapshot = await usersRef.where("email", "==", email).get();

    if (snapshot.empty) {
      return res.status(404).json({ error: "User not found" });
    }

    // assuming email is unique
    const userData = snapshot.docs[0].data();
    res.status(200).json(userData);
  } catch (error) {
    console.error("Error logging in user:", error);
    res.status(500).json({ error: "Failed to login" });
  }
};

module.exports = {
  createUser,
  getUser,
  loginUser,
};
