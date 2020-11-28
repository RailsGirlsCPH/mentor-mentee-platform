import React from "react";
import "./avatar.css";
import avatarPhoto from "./avatar.jpg";

const Avatar = () => {
  return (
    <div className="avatar">
      <img src={avatarPhoto} alt="avatar" className="avatar-img" />
    </div>
  );
};

export default Avatar;
