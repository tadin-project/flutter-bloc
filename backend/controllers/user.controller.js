import validator from "validator";
import { v4 as uuidV4 } from "uuid";

import db from "../config/db.js";
import {
  appResponse,
  asyncHandler,
  errorMessage,
  passwordHandler,
} from "../utils/index.js";

const getAll = asyncHandler(async (req, res) => {
  const data = await db.user.findMany({
    select: {
      name: true,
      email: true,
      isVerified: true,
      verifiedAt: true,
      uuid: true,
      roleId: true,
      role: true,
    },
  });

  res.json(
    appResponse(true, {
      data: data.map(function (i) {
        const dt = {
          id: i.uuid,
          email: i.email,
          name: i.name,
          role_id: i.roleId,
          role_name: i.role.name,
          is_verified: i.isVerified,
          verified_at: i.verifiedAt,
        };
        return dt;
      }),
    })
  );
});

const getById = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) {
    errorMessage("Id can not null", 400);
  }

  const currUser = await db.user.findFirst({
    where: {
      uuid: id,
    },
  });

  if (!currUser) {
    errorMessage("User not found", 404);
  }

  currUser.id = currUser.uuid;
  delete currUser.uuid;
  delete currUser.password;

  res.json(
    appResponse(true, {
      data: currUser,
    })
  );
});

const add = asyncHandler(async (req, res) => {
  const { name, email, password, role_id } = req.body;

  if (!email || !password || !role_id) {
    errorMessage("Email, password, and role_id is required", 400);
  }

  if (!validator.isEmail(email)) {
    errorMessage("Email format is invalid", 400);
  }

  const checkUser = await db.user.findFirst({
    where: {
      email,
    },
  });

  if (checkUser) {
    errorMessage("Email has used", 400);
  }

  const userData = await db.user.create({
    data: {
      uuid: uuidV4(),
      name,
      email,
      password: await passwordHandler.generate(password),
      roleId: parseInt(role_id),
      isVerified: true,
      verifiedAt: new Date(Date.now()),
    },
  });

  delete userData.id;
  delete userData.password;

  res.status(201).json(
    appResponse(true, {
      message: "Success create user",
      data: {
        id: userData.uuid,
        name: userData.name,
        email: userData.email,
        role_id: userData.roleId,
        is_verified: userData.isVerified,
        verified_at: userData.verifiedAt,
      },
    })
  );
});

const update = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) {
    errorMessage("Data unknown", 404);
  }

  const currUser = await db.user.findFirst({
    where: {
      uuid: id,
    },
  });

  if (!currUser) {
    errorMessage("Data unknown", 404);
  }

  const { name, email, password, role_id, is_change_password } = req.body;

  if (!email || !role_id) {
    errorMessage("Email and role id is required", 400);
  }

  const dataUpdate = {
    name,
    email,
    roleId: parseInt(role_id),
  };

  if (is_change_password) {
    dataUpdate.password = await passwordHandler.generate(password);
  }

  const userData = await db.user.update({
    where: {
      id: currUser.id,
    },
    data: dataUpdate,
  });

  delete userData.password;
  delete userData.id;

  res.json(
    appResponse(true, {
      message: "Update success",
      data: {
        id: userData.uuid,
        name: userData.name,
        email: userData.email,
        role_id: userData.roleId,
        is_verified: userData.isVerified,
        verified_at: userData.verifiedAt,
      },
    })
  );
});

const remove = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) {
    errorMessage("Data unknown", 404);
  }

  const currUser = await db.user.findFirst({ where: { uuid: id } });

  if (!currUser) {
    errorMessage("Data unknown", 404);
  }

  await db.user.delete({ where: { id: currUser.id } });
  res.json(appResponse(true, { message: "Delete success" }));
});

export default {
  getAll,
  getById,
  add,
  update,
  delete: remove,
};
