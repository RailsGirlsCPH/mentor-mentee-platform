import React from "react";
import "./Input.css";

const Input = ({ type, name, value }) => {
    return <input type={type} name={name} value={value}></input>;
};

export default Input;
