import AddName from "@/component/name/AddName";
import ListNames from "@/component/name/ListNames";
import { useEffect, useState } from "react";
import AxiosStatic, { AxiosRequestConfig, AxiosResponse } from "axios";
import { type Name } from "@/type/name";

export const NamePage = () => {
  const [names, setNames] = useState<Name[]>([]);

  const url = "https://${}.execute-api.ap-northeast-1.amazonaws.com/dev/name";

  const axiosReqConfig: AxiosRequestConfig = {
    // withCredentials: true,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // 'Access-Control-Allow-Origin' : '*',
    },
  };

  const axios = AxiosStatic.create(axiosReqConfig);

  const fetchData = async () => {
    const result: AxiosResponse<any, any> = await axios.get(url); // API-GWのGETを叩いて、データを取得する
    const items: Array<Name> = result.data;
    setNames(items);
  };

  // HTTP Getが完了するまで描画を遅延させる処理
  useEffect(() => {
    fetchData();
  }, []);

  /**
   * テキストボックスに入力された名前をPOSTする
   * @param inputName
   */
  const addName = async (inputName: string): Promise<void> => {
    const data = JSON.stringify({ name: inputName });
    await axios.post(url, data);
    fetchData();
  };

  return (
    <>
      <AddName onClick={addName} />
      <hr />
      <ListNames names={names} />
    </>
  );
};
