import React from "react";
import { type Name } from "@/type/name";


interface Props {
  names: Name[];
}

const ListNames: React.FC<Props> = ({ names }: Props) => {
  if (names.length <= 0) {
    return <div>no data</div>;
  }

  const list = [];

  for (const name of names) {
    list.push(
      <tr key={name.id}>
        <td>{name.name}</td>
      </tr>
    );
  }

  return <table><tbody>{list}</tbody></table>;
};

export default ListNames;
