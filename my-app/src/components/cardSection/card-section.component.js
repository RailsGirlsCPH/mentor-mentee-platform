import React from "react";
import "./card-section.css";

const CardSection = ({ section }) => {
  return (
    <div className="card-section">
      <h6>{section.title}</h6>
      <p>{section.text}</p>
    </div>
  );
};

export default CardSection;
