import express from "express";
import { userController } from "../controllers/index.js";

const router = express.Router();

router.get("/", userController.getAll);
router.post("/", userController.add);
router.get("/:id", userController.getById);
router.put("/:id", userController.update);
router.delete("/:id", userController.delete);

export default router;
