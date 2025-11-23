"use client";
import { useState, type Dispatch, type SetStateAction } from "react";

const buttonStyle = {
  color: "#fff",
  backgroundColor: "#eb6100",
  border: "none",
  borderRadius: "4px",
  padding: "8px 16px",
  cursor: "pointer",
  marginTop: "16px",
  ":hover": {
    backgroundColor: "#f56500",
  },
};

const txtboxStyle = {
  display: "block",
  width: "500px",
  marginTop: "50px",
  padding: "15px",
  border: "none",
  borderRadius: "5px",
  fontSize: "16px",
  color: "#a0a0a0",
  outline: "none",
};

type Props = {
  onClick: (name: string) => Promise<void>;
};

const AddName = ({ onClick } : Props) => {
  const [inputName, setInputName]: [string, Dispatch<SetStateAction<string>>] = useState("");

  const handleClick = async() => {
    await onClick(inputName);
    setInputName("");
  };

  return (
    <div>
      <input
        type="text"
        id="uname"
        placeholder="input ur name!"
        value={inputName}
        onInput={(e) => setInputName(e.currentTarget.value)}
        style={txtboxStyle}
        />
      <p>Name: {inputName}</p>
      <button style={buttonStyle} onClick={handleClick}>
        post!
      </button>
    </div>
  );
};

export default AddName;
