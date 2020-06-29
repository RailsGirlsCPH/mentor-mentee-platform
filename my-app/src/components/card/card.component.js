import React from "react";
import PropTypes from "prop-types";
import "./card.css";
import Name from "../name/name.component";
import Avatar from "../avatar/avatar.component";
import Role from "../role/role.component";
import CardSection from "../cardSection/card-section.component";

const Card = ({ name, mentor, mentee, section }) => {
  return (
    <div
      className={
        mentor && mentee
          ? "mentor-mentee card"
          : mentee
          ? "mentee card"
          : "card"
      }
    >
      <div className={section.length > 1 ? "extended content" : "content"}>
        <Avatar />
        <Name name={name} />
        <Role mentor={mentor} mentee={mentee} />
        {section.length > 1 ? (
          section.map((article, index) => (
            <CardSection key={index} section={article} />
          ))
        ) : (
          <CardSection section={section[0]} />
        )}
      </div>
    </div>
  );
};

Card.propTypes = {
  mentor: PropTypes.bool.isRequired,
  mentee: PropTypes.bool.isRequired
};

export default Card;
