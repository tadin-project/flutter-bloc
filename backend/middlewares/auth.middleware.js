import { asyncHandler, errorMessage, jwtHandler } from "../utils/index.js";
import db from "../config/db.js";

const authMiddleware = asyncHandler(async (req, res, next) => {
  let token = req.cookies.jwt;

  if (!token) {
    errorMessage("Not authorization, no token", 401);
  }

  const decodedData = jwtHandler.verify(token);
  const currUser = await db.user.findFirst({
    where: {
      id: decodedData.id,
    },
    select: {
      id: true,
      name: true,
      email: true,
      isVerified: true,
      verifiedAt: true,
      role: true,
    },
  });

  if (!currUser) {
    errorMessage("Not authorization");
  }

  req.user = currUser;
  next();
});

export default authMiddleware;
