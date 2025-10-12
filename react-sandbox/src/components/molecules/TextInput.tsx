import type { TextInputProps } from "#/TextInputProps";
import { useRecoilState } from "recoil";

export const TextInput = ({ state }: TextInputProps) => {
  const [text, setText] = useRecoilState(state);

  const onChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setText(event.target.value);
  };

  return (
    <div>
      <input type="text" value={text} onChange={onChange} />
      Echo: {text}
    </div>
  );
};
