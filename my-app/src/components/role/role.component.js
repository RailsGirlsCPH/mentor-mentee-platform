import React from "react";
import PropTypes from "prop-types";

import "./role.css";

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

Role.propTypes = {
  mentor: PropTypes.bool.isRequired,
  mentee: PropTypes.bool.isRequired
};

export default Role;
