import { CharacterCountProps } from "#/CharacterCountProps";
import { useRecoilValue } from "recoil";

export const CharacterCount = ({ state }: CharacterCountProps) => {
  const count = useRecoilValue(state);

  return <>Character Count: {count}</>;
};
