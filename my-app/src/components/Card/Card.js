import React from 'react';
import PropTypes from 'prop-types';
import './Card.css';
import Name from '../name/Name';
import Avatar from '../avatar/avatarComponent';
import Skill from '../skill/Skill.component';
import Link from '../link/linkComponent';

const Card = ({ name, skills, contact, more }) => {
  return (
    <div className="card">
      <Avatar />
      <Name name={name} />
      <div className="skills-block">
        {skills.length > 1 ? (
          skills.map(skill => <Skill skills={skill} />)
        ) : (
          <Skill skills={skills} />
        )}
      </div>
      <Link link={contact.link} text={contact.text} />
      <div className="right">
        <Link link={more.link} text={more.text} />
      </div>
    </div>
  );
};

Card.propTypes = {
  contact: PropTypes.shape({
    link: PropTypes.string.isRequired,
    text: PropTypes.string.isRequired
  }),
  more: PropTypes.shape({
    link: PropTypes.string.isRequired,
    text: PropTypes.string.isRequired
  })
};
export default Card;
