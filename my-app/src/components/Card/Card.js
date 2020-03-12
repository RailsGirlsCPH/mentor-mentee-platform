import React from 'react';
import './Card.css';
import Name from '../name/Name';
import Avatar from '../avatar/avatarComponent';
import Skill from '../skill/Skill.component';
<<<<<<< HEAD
import Link from '../link/linkComponent.jsx';

const Card = ({name, skills, link, text}) => {
=======

const Card = ({name, skills}) => {
>>>>>>> 3a357b11dc8b8c1e75cd9646d665bf452d3fe8ab
    return (
        <div className="card">
           <Avatar />
           <Name name={name} />
           <div className="skills-block">
            {skills.length > 1 
            ? skills.map(skill => <Skill skills={skill} />)
            : <Skill skills={skills} />}
           </div>
<<<<<<< HEAD
           <Link link={link} text={text} className='contact-link'/>
=======
>>>>>>> 3a357b11dc8b8c1e75cd9646d665bf452d3fe8ab
        </div>
    )
}

export default Card;