import React from "react";
import {storiesOf} from "@storybook/react";
// Import your component file here
import Avatar from "../components/avatar/avatarComponent";
import Input from "../components/Input/Input"
import SampleButton from "../components/sampleButton/sampleButton.component";
import Link from "../components/link/linkComponent";
import Name from "../components/name/Name";
import Card from "../components/Card/Card";
import Skill from "../components/skill/Skill.component";

// Add the stories of your components here
storiesOf('Avatar', module).add('avatar', () => <Avatar />);
storiesOf('Input', module).add('input text', () => <Input type="text" name="name" />);
storiesOf('Input', module).add('input checkbox', () => <Input type="checkbox" name="Name" />);
storiesOf('Sample button', module).add('sample button', () => <SampleButton />);
storiesOf('Link Component', module).add('link contact', () => (
  <Link link="mailto:example@gmail.com" text="Contact" />
));
storiesOf('Link Component', module).add('link more', () => (
  <Link link="/username" text="More" />
));
storiesOf('Name', module).add('first name', () => <Name name="Joe" />);
storiesOf('Name', module).add('surname', () => <Name name="Johnson" />);
storiesOf('Skill', module).add('skill', () => <Skill skills="JavaScript" />);
storiesOf('Card', module).add('card', () => (
  <Card
    name="Johnson"
    skills={["JavaScript", "PHP", "HTML"]}
    contact={{ link: "mailto:example@gmail.com", text: "Contact" }}
    more={{ link: "/username", text: "More" }}
  />
));
