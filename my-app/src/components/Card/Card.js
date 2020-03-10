import React from 'react';
import './Card.css';
import Name from '../name/Name';
import Avatar from '../avatar/avatarComponent'

const Card = ({name}) => {
    return (
        <div className="card">
           <Avatar />
           <Name name={name} />
        </div>
    )
}

export default Card;