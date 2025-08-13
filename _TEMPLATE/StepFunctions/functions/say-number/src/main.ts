export const main = async (event: any): Promise<any> => {
  const isOdd = event.isOdd;

  const str = isOdd ? "odd" : "even";

  const msg = `The number is ${str}`;
  console.log(msg);
  return {
    httpstatus: 200,
    message: `The number is ${str}`,
  };
};
