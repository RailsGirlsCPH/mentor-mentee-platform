import React from "react";
import "./user-card-section.css";

const UserCardSection = ({ title, text }) => {
  return (
    <section className="user-card">
      <h6>{title}</h6>
      <p>{text}</p>
    </section>
  );
};

export default UserCardSection;
