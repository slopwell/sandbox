import { RecoilState, atom, selector } from "recoil";
import { CharacterCount } from "../atoms/CharacterCount";
import { TextInput } from "../molecules/TextInput";

const textState: RecoilState<string> = atom({
  key: "textState",
  default: "default-str",
});

const CharacterCountState = selector({
  key: "characterCountState",
  get: ({ get }) => {
    const text = get(textState);
    return text.length;
  },
});

export const CharacterCounter = () => {
  return (
    <div>
      <TextInput state={textState} />
      <CharacterCount state={CharacterCountState} />
    </div>
  );
};
