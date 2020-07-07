import React from "react";
import "./user-card-section.css";

const UserCardSection = ({ sections }) => {
  return (
    <section className="user-card">
      <h6>{sections.title}</h6>
      <p>{sections.text}</p>
    </section>
  );
};

export default UserCardSection;
