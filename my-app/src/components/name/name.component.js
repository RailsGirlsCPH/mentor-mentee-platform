import React from "react";
import "./name.css";

const Name = ({ name }) => {
  return (
    <div className="name">
      <h5>{name}</h5>
    </div>
  );
};

export default Name;
