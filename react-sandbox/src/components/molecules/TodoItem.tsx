import { Todo } from "#/Todo";
import { RecoilState, useRecoilState } from "recoil";

function replaceItemAtIndex(
  arr: Todo.Item[],
  index: number,
  newValue: Todo.Item
) {
  return [...arr.slice(0, index), newValue, ...arr.slice(index + 1)];
}

function removeItemAtIndex(arr: Todo.Item[], index: number) {
  return [...arr.slice(0, index), ...arr.slice(index + 1)];
}

type Props = {
  item: Todo.Item;
  todoListState: RecoilState<Todo.Item[]>;
};

export const TodoItem = ({ item, todoListState }: Props) => {
  const [todoList, setTodoList] = useRecoilState(todoListState);
  const index = todoList.findIndex((listItem) => listItem === item);

  const editItemText = ({
    target: { value },
  }: React.ChangeEvent<HTMLInputElement>) => {
    const newList = replaceItemAtIndex(todoList, index, {
      ...item,
      text: value,
    });

    setTodoList(newList);
  };

  const toggleItemCompletion = () => {
    const newList = replaceItemAtIndex(todoList, index, {
      ...item,
      isComplete: !item.isComplete,
    });

    setTodoList(newList);
  };

  const deleteItem = () => {
    const newList = removeItemAtIndex(todoList, index);

    setTodoList(newList);
  };

  return (
    <div>
      <input type="text" value={item.text} onChange={editItemText} />
      <input
        type="checkbox"
        checked={item.isComplete}
        onChange={toggleItemCompletion}
      />
      <button onClick={deleteItem}>X</button>
    </div>
  );
};
