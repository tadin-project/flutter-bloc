const errorMessage = (message, statusCode = 500) => {
  const err = new Error(message);
  if (statusCode) {
    err.statusCode = statusCode;
  }

  throw err;
};

export default errorMessage;
