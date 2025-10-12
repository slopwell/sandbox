import type { Todo } from "#/Todo";
import { atom, useRecoilValue } from "recoil";
import { TodoItem } from "@/molecules/TodoItem";
import { TodoItemCreater } from "@/organisms/TodoItemCreater";

const todoListState = atom<Todo.Item[]>({
  key: "TodoList",
  default: [],
});

export const TodoList = () => {
  const todoList = useRecoilValue(todoListState);

  return (
    <>
      <TodoItemCreater state={todoListState} />

      {todoList.map((it) => (
        <TodoItem key={it.id} item={it} todoListState={todoListState} />
      ))}
    </>
  );
};
