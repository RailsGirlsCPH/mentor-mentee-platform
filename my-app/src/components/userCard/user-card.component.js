import React from "react";
import PropTypes from "prop-types";
import "./user-card.css";
import Name from "../name/name.component";
import Avatar from "../avatar/avatar.component";
import Role from "../role/role.component";
import UserCardSection from "../userCardSection/user-card-section.component";

const UserCard = ({ name, mentor, mentee, sections }) => {
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
      <div className={sections.length > 1 ? "extended content" : "content"}>
        <Avatar />
        <Name name={name} />
        <Role mentor={mentor} mentee={mentee} />
        {sections.length > 0 &&
          sections.map((article, index) => (
            <UserCardSection key={index} sections={article} />
          ))}
      </div>
    </div>
  );
};

UserCard.propTypes = {
  mentor: PropTypes.bool.isRequired,
  mentee: PropTypes.bool.isRequired
};

export default UserCard;
