const appResponse = (status, { message = "", data = null }) => {
  return {
    status,
    message,
    data,
  };
};

export default appResponse;
