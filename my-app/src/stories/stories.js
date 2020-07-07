import React from "react";
import { storiesOf } from "@storybook/react";
// Import your component file here
import Avatar from "../components/avatar/avatar.component";
import Input from "../components/input/input.component";
import SampleButton from "../components/sampleButton/sample-button.component";
import Link from "../components/link/link.component";
import Name from "../components/name/name.component";
import UserCard from "../components/userCard/user-card.component";
import Skill from "../components/userSkill/user-skill.component";
import Role from "../components/role/role.component";

// Add the stories of your components here
storiesOf("Avatar", module).add("avatar", () => <Avatar />);
storiesOf("Input", module).add("input text", () => (
  <Input type="text" name="name" />
));
storiesOf("Input", module).add("input checkbox", () => (
  <Input type="checkbox" name="Name" />
));
storiesOf("Sample button", module).add("sample button", () => <SampleButton />);
storiesOf("Link Component", module).add("link contact", () => (
  <Link link="mailto:example@gmail.com" text="Contact" />
));
storiesOf("Link Component", module).add("link more", () => (
  <Link link="/username" text="More" />
));
storiesOf("Name", module).add("first name", () => (
  <Name name="MaryAnn Salvato" />
));
storiesOf("Name", module).add("surname", () => <Name name="Johnson" />);
storiesOf("Skill", module).add("skill", () => <Skill skills="JavaScript" />);
storiesOf("Role", module).add("mentor", () => (
  <Role role="" mentor={false} mentee={true} />
));
storiesOf("Role", module).add("mentor/mentee", () => (
  <Role role="" mentor={true} mentee={true} />
));

storiesOf("User Card", module).add("card mentor", () => (
  <UserCard
    name="MaryAnn Salvato"
    mentor={true}
    mentee={false}
    sections={[
      { title: "Looking to", text: "Help other women to get into tech" }
    ]}
  />
));

storiesOf("User Card", module).add("card mentee", () => (
  <UserCard
    name="MaryAnn Salvato"
    mentor={false}
    mentee={true}
    sections={[
      { title: "Looking for", text: "Sparring and helping with React code" }
    ]}
  />
));

storiesOf("User Card", module).add("card extended", () => (
  <UserCard
    name="MaryAnn Salvato"
    mentor={true}
    mentee={true}
    sections={[
      { title: "Looking to", text: "Help other women to get into tech" },
      {
        title: "Looking for",
        text: "Help with code and contacts in the field"
      },
      { title: "Experience", text: "Teacher" },
      {
        title: "Extra notes",
        text:
          "I have been working as a teacher but want to enter the world of tech."
      }
    ]}
  />
));
