import React from 'react'
import './link.css'


<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4cbe854a031e450f7944a89848d6ccb9c3160404
const Link = ({link, text}) => {
    return (
        <div>
            <a href={link}>{text}</a>
<<<<<<< HEAD
=======
const Link = ({email}) => {
    return (
        <div>
            <a href={`mailto:${email}`} className='contact-link'>Contact</a>
>>>>>>> 3a357b11dc8b8c1e75cd9646d665bf452d3fe8ab
=======
>>>>>>> 4cbe854a031e450f7944a89848d6ccb9c3160404
        </div>
    )
}

export default Link