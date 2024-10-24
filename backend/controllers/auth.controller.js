import validator from "validator";
import { v4 as uuidV4 } from "uuid";

import db from "../config/db.js";
import {
  appResponse,
  asyncHandler,
  errorMessage,
  jwtHandler,
  passwordHandler,
} from "../utils/index.js";

const _createCookie = (res, statusCode, type, dataCookie, data) => {
  const cookieOption = {
    expire: new Date(Date.now() + 6 * 24 * 60 * 60 * 1000),
    httpOnly: true,
    security: false,
  };

  res.cookie(type, dataCookie, cookieOption);
  res.status(statusCode).json(data);
};

const register = asyncHandler(async (req, res) => {
  const { name, email, password } = req.body;
  if (!email || !password) {
    errorMessage("Email and password is required", 400);
  }

  if (!validator.isEmail(email)) {
    errorMessage("Email is invalid", 400);
  }

  const checkUser = await db.user.findFirst({
    where: {
      email,
    },
  });

  if (checkUser) {
    errorMessage("Email must unique", 400);
  }

  const data = await db.user.create({
    data: {
      uuid: uuidV4(),
      email,
      name,
      password: await passwordHandler.generate(password),
      roleId: 3,
    },
  });

  delete data.id;
  delete data.password;
  delete data.isVerified;

  _createCookie(
    res,
    201,
    "jwt",
    jwtHandler.generate({ id: data.uuid }),
    appResponse(true, {
      message: "User has registered. Please check your email to verify it",
      data,
    })
  );
});

const login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    errorMessage("Email and password is required", 400);
  }

  const userData = await db.user.findFirst({
    where: {
      email,
    },
  });

  if (!userData) {
    errorMessage("Credentials Invalid", 400);
  }

  res.status(200);
  const isMatch = await passwordHandler.verify(password, userData.password);
  if (!isMatch) {
    errorMessage("Credentials Invalid", 400);
  }

  delete userData.id;
  delete userData.password;
  delete userData.verifiedAt;

  _createCookie(
    res,
    200,
    "jwt",
    jwtHandler.generate({ id: userData.uuid }),
    appResponse(true, { message: "Login Success", data: userData })
  );
});

const getUser = asyncHandler(async (req, res) => {
  res.json(appResponse(true, { data: req.user }));
});

const logout = asyncHandler(async (req, res) => {
  res.cookie("jwt", "", {
    httpOnly: true,
    expire: new Date(Date.now()),
  });

  res.json(appResponse(true, { message: "Logout success" }));
});

export default {
  getUser,
  login,
  logout,
  register,
};
