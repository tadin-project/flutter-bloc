import bcryptjs from "bcryptjs";

const generate = async (password) => {
  const salt = await bcryptjs.genSalt();
  const newPassword = await bcryptjs.hash(password, salt);
  return newPassword;
};

const verify = async (password, passwordHash) => {
  const isMatch = await bcryptjs.compare(password, passwordHash);
  return isMatch;
};

export default { generate, verify };
