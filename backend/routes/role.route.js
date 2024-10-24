import express from "express";
import { roleController } from "../controllers/index.js";

const router = express.Router();

router.get("/", roleController.getAll);
router.post("/", roleController.add);
router.get("/:id", roleController.getById);
router.put("/:id", roleController.update);
router.delete("/:id", roleController.delete);

export default router;
