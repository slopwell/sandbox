import { RecoilRoot } from "recoil";
import "@/styles/App.css";
// import { CharacterCounter } from "../organisms/CharacterCounter";
import { TodoList } from "@/pages/TodoList";

function App() {
  return (
    <RecoilRoot>
      <TodoList />
    </RecoilRoot>
  );
}

export default App;
