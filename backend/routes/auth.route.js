import express from "express";
import { authController } from "../controllers/index.js";
import { authMiddleware } from "../middlewares/index.js";

const router = express.Router();

router.post("/login", authController.login);
router.post("/register", authController.register);
router.post("/logout", authMiddleware, authController.logout);
router.get("/getuser", authMiddleware, authController.getUser);

export default router;
