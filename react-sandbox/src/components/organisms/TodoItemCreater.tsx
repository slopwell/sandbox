import { Todo } from "#/Todo";
import { useState } from "react";
import { RecoilState, useSetRecoilState } from "recoil";

let id = 0;
function getId() {
  return id++;
}

type Prop = {
  state: RecoilState<Todo.Item[]>;
};

export const TodoItemCreater = ({ state }: Prop) => {
  const [inputValue, setInputValue] = useState("");
  const setTodoList = useSetRecoilState(state);

  const addItem = () => {
    setTodoList((oldTodoList) => [
      ...oldTodoList,
      {
        id: getId(),
        text: inputValue,
        isComplete: false,
      },
    ]);
    setInputValue("");
  };

  const onChange = ({
    target: { value },
  }: React.ChangeEvent<HTMLInputElement>) => {
    setInputValue(value);
  };

  return (
    <div>
      <input type="text" value={inputValue} onChange={onChange} />
      <button onClick={addItem}>Add</button>
    </div>
  );
};
