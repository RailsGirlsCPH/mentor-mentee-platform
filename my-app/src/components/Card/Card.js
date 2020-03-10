import React from 'react';
import './Card.css';
import Name from '../name/Name';
import Avatar from '../avatar/avatarComponent';
import Skill from '../skill/Skill.component';

const Card = ({name, skills}) => {
    return (
        <div>
           <Avatar />
           <Name name={name} />
           <div className="skills-block">
            {skills.length > 1 
            ? skills.map(skill => <Skill skills={skill} />)
            : <Skill skills={skills} />}
           </div>
        </div>
    )
}

export default Card;