import React from 'react'
import './link.css'


const Link = ({email}) => {
    return (
        <div>
            <a href={`mailto:${email}`} className='contact-link'>Contact</a>
        </div>
    )
}

export default Link