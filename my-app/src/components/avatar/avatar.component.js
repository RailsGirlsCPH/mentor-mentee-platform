import React from 'react';
import './avatar.css';
import avatarPhoto from  './avatar.jpg';

const Avatar = () => {
    return (
        <div>
            <img src={avatarPhoto} alt="avatar" />
        </div>
    )
}

export default Avatar;