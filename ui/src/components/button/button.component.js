import React from "react";
import "./button.css";

const Button = (props) => {
    const { onClick, children, variant = "default" } = props;
    switch (variant) {
        case "white":
            return (
                <button className="white" onClick={onClick}>
                    {children}
                </button>
            );
        default:
            return <button onClick={onClick}>{children}</button>;
    }
};

export default Button;
