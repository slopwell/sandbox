export const main = async (event: any): Promise<any> => {
  const number = event.number;
  const isOdd = number % 2 === 1;
  return {
    isOdd,
  };
};
