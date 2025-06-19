
const express = require("express");
const app = express();
const { db } = require("./config/firebase");
const cors = require("cors");

app.use(cors({
  origin: "*", // or "http://localhost:YOUR_PORT"
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type"],
}));

const userRoutes = require("./routes/userRoutes");
app.use("/api/users", userRoutes);

// middleware
app.use(cors());
app.use(express.json());

const dummyProducts = [
  {
    title: 'Study Planner Notebook',
    description: 'Organize your NEET prep with daily/weekly layouts.',
    price: 12.99,
    imageUrl: 'https://m.media-amazon.com/images/I/81Q-IBt-dYL.jpg',
  },
  {
    title: 'Flashcard Set – Biology',
    description: '500 illustrated flashcards for quick review.',
    price: 19.99,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq2xqsqj8vmqvmUZCpBmRu4r7xmSG1vec0lw&s',
  },
  {
    title: 'Memory Training App Guide',
    description: 'Downloadable PDF + access code.',
    price: 9.49,
    imageUrl: 'https://m.media-amazon.com/images/I/614bcxyyS8L._AC_UF1000,1000_QL80_.jpg',
  },
  {
    title: 'Revision Poster Pack',
    description: 'Set of 5 colorful educational posters.',
    price: 14.75,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuE-kuZ9tYvMtyJuMPpdwMVy2-7SM8qi7E7w&s',
  },
  {
    title: 'Motivational Stickers',
    description: 'Pack of 20 stickers for your study space.',
    price: 4.99,
    imageUrl: 'https://images.vexels.com/media/users/3/267173/raw/522b7d16fb50338af573f9ef1ddd2d5b-motivational-positive-quotes-sticker-set.jpg',
  }
];
app.post("/add-products", async (req, res) => {
  try {
    const batch = db.batch(); 

    dummyProducts.forEach((product) => {
      const docRef = db.collection("products").doc();
      batch.set(docRef, product);
    });

    await batch.commit();
    res.send("Dummy products added successfully ✅");
  } catch (error) {
    console.error("❌ Firestore Error:", error); // Add this
    res.status(500).send("Failed to add products ❌");
  }
});


app.get("/", (req, res) => {
  res.send("🎉 Welcome to the backend!");
});

app.listen(5000, () => {
  console.log("🚀 Server is running at http://localhost:5000");
});
