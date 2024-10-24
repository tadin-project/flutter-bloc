import jwt from "jsonwebtoken";
import errorMessage from "./errorMessage.js";

const generate = (data) => {
  const JWT_SECRET = process.env.JWT_SECRET;
  if (!JWT_SECRET) {
    errorMessage("Please create JWT secret first in .env", 500);
  }

  const token = jwt.sign(data, JWT_SECRET, { expiresIn: "6d" });
  return token;
};

const verify = (token) => {
  const JWT_SECRET = process.env.JWT_SECRET;
  if (!JWT_SECRET) {
    errorMessage("Please create JWT secret first in .env", 500);
  }

  const data = jwt.verify(token, JWT_SECRET);
  return data;
};

export default {
  generate,
  verify,
};
