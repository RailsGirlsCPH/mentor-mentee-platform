import React from 'react'
import './link.css'


<<<<<<< HEAD
const Link = ({link, text}) => {
    return (
        <div>
            <a href={link}>{text}</a>
=======
const Link = ({email}) => {
    return (
        <div>
            <a href={`mailto:${email}`} className='contact-link'>Contact</a>
>>>>>>> 3a357b11dc8b8c1e75cd9646d665bf452d3fe8ab
        </div>
    )
}

export default Link