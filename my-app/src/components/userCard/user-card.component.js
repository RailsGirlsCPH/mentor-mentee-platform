import React from "react";
import PropTypes from "prop-types";
import "./user-card.css";
import Avatar from "../avatar/avatar.component";
import UserCardSection from "../userCardSection/user-card-section.component";

const Name = ({ name }) => {
  return (
    <div className="name">
      <h5>{name}</h5>
    </div>
  );
};

const Role = ({ mentor, mentee }) => {
  return (
    <div className="role">
      <h6>
        {mentor && mentee ? (
          <>
            <span>Mentor</span> /<span> Mentee</span>
          </>
        ) : mentee ? (
          <span>Mentee</span>
        ) : (
          <span>Mentor</span>
        )}
      </h6>
    </div>
  );
};

function getClassName(user) {
  const classes = ["card"];
  user.mentor && classes.push("mentor");
  user.mentee && classes.push("mentee");
  return classes.join(" ");
}

const UserCard = ({ user, sections }) => {
  const { name, mentor, mentee } = user;
  return (
    <div className={getClassName(user)}>
      <div className={sections.length > 1 ? "extended content" : "content"}>
        {}
        <Avatar />
        <Name name={name} />
        <Role mentor={mentor} mentee={mentee} />
        {sections.length > 0 &&
          sections.map((article, index) => (
            <UserCardSection
              key={index}
              title={article.title}
              text={article.text}
            />
          ))}
      </div>
    </div>
  );
};

UserCard.propTypes = {
  user: PropTypes.object.isRequired,
  sections: PropTypes.array.isRequired
};

export default UserCard;
