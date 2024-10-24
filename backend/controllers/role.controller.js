import db from "../config/db.js";
import { appResponse, asyncHandler, errorMessage } from "../utils/index.js";

const getAll = asyncHandler(async (req, res) => {
  const data = await db.role.findMany({
    where: {
      status: true,
    },
    orderBy: {
      kode: "asc",
    },
  });

  res.json(
    appResponse(true, {
      data,
    })
  );
});

const getById = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) {
    errorMessage("Id can not null", 400);
  }

  const currRole = await db.role.findFirst({
    where: {
      id: parseInt(id),
    },
  });

  if (!currRole) {
    errorMessage("Role not found", 404);
  }

  res.json(
    appResponse(true, {
      data: currRole,
    })
  );
});

const add = asyncHandler(async (req, res) => {
  const { kode, name, status } = req.body;

  if (!kode) {
    errorMessage("Kode is required", 400);
  }

  const checkRole = await db.role.findFirst({
    where: {
      kode,
    },
  });

  if (checkRole) {
    errorMessage("Kode has used", 400);
  }

  const roleData = await db.role.create({
    data: {
      name,
      kode,
      status,
    },
  });

  res.json(
    appResponse(true, {
      message: "Success create role",
      data: roleData,
    })
  );
});

const update = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) {
    errorMessage("Data unknown", 404);
  }

  const currRole = await db.role.findFirst({
    where: {
      id,
    },
  });

  if (!currRole) {
    errorMessage("Data unknown", 404);
  }

  const { kode, name, status } = req.body;

  if (!kode) {
    errorMessage("Kode is required", 400);
  }

  const dataUpdate = {
    name,
    kode,
    status,
  };

  const roleData = await db.role.update({
    where: {
      id: currRole.id,
    },
    data: dataUpdate,
  });

  res.json(appResponse(true, { message: "Update success", data: roleData }));
});

const remove = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) {
    errorMessage("Data unknown", 404);
  }

  const currRole = await db.role.findFirst({ where: { id } });

  if (!currRole) {
    errorMessage("Data unknown", 404);
  }

  await db.role.delete({ where: { id: currRole.id } });
  res.json(appResponse(true, { message: "Delete success" }));
});

export default {
  getAll,
  getById,
  add,
  update,
  delete: remove,
};
