import React from 'react';
import './Card.css';
import Name from '../name/Name';
import Avatar from '../avatar/avatarComponent';
import Skill from '../skill/Skill.component';
<<<<<<< HEAD
<<<<<<< HEAD
import Link from '../link/linkComponent.jsx';

const Card = ({name, skills, link, text}) => {
=======

const Card = ({name, skills}) => {
>>>>>>> 3a357b11dc8b8c1e75cd9646d665bf452d3fe8ab
=======
import Link from '../link/linkComponent.jsx';

const Card = ({name, skills, link, text}) => {
>>>>>>> 4cbe854a031e450f7944a89848d6ccb9c3160404
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
<<<<<<< HEAD
           <Link link={link} text={text} className='contact-link'/>
=======
>>>>>>> 3a357b11dc8b8c1e75cd9646d665bf452d3fe8ab
=======
           <Link link={link} text={text} className='contact-link'/>
>>>>>>> 4cbe854a031e450f7944a89848d6ccb9c3160404
        </div>
    )
}

export default Card;