import React from "react";
import "./input.css";

const Input = ({
    type,
    name,
    value,
    className,
    onChange,
    checked,
    required,
    minLength,
}) => {
    return (
        <input
            type={type}
            name={name}
            value={value}
            onChange={onChange}
            className={className}
            checked={checked}
            required={required}
            minLength={minLength}
        ></input>
    );
};

export default Input;
