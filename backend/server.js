import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";

import { authRoute, roleRoute, userRoute } from "./routes/index.js";
import { errorHandler } from "./utils/index.js";

dotenv.config();
const PORT = process.env.PORT || 3001;
const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use("/api/v1/auth", authRoute);
app.use("/api/v1/roles", roleRoute);
app.use("/api/v1/users", userRoute);

app.use(errorHandler);

app.listen(PORT, () => console.log(`Server run on port:${PORT}`));
