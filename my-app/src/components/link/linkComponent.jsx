import React from 'react'
import './link.css'

const Link = ({link, text}) => {
    return (
        <div>
            <a href={link}>{text}</a>
        </div>
    )
}

export default Link