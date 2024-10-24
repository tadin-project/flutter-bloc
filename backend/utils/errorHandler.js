const errorHandler = (error, req, res, next) => {
  const statusCode = error.statusCode || 500;

  const message = error.message;

  res.status(statusCode).json({
    message: message,
    status: false,
  });
};

export default errorHandler;
