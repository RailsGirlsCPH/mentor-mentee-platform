import React from 'react';
import './Card.css';
import Name from '../name/Name';
import Avatar from '../avatar/avatarComponent';
import Skill from '../skill/Skill.component';
import Link from '../link/linkComponent.jsx';

const Card = ({name, skills, link, text}) => {
    return (
        <div className="card">
           <Avatar />
           <Name name={name} />
           <div className="skills-block">
            {skills.length > 1 
            ? skills.map(skill => <Skill skills={skill} />)
            : <Skill skills={skills} />}
           </div>
           <Link link={link} text={text} className='contact-link'/>
        </div>
    )
}

export default Card;