import React from "react";
import { storiesOf } from "@storybook/react";

import { withKnobs, text } from "@storybook/addon-knobs";
import { action } from "@storybook/addon-actions";
console.log(withKnobs);
// Import your component file here
import Avatar from "../components/avatar/avatar.component";
import Input from "../components/inputs/input.component";
import Button from "../components/button/button.component";
import Link from "../components/link/link.component";
import UserCard from "../components/userCard/user-card.component";
import SignupForm from "../components/signupForm/signup-form.component";

// Add the stories of your components here
storiesOf("Avatar", module).add("avatar", () => <Avatar />);
storiesOf("Input", module).add("input text", () => (
    <Input type="text" name="name" />
));
storiesOf("Input", module).add("input checkbox", () => (
    <Input type="checkbox" name="Name" />
));
storiesOf("Button", module)
    .add("default button", () => (
        <Button onClick={action("button clicked")}>Submit</Button>
    ))
    .add("white button", () => (
        <Button onClick={action("button clicked")} variant="white">
            Submit
        </Button>
    ));
storiesOf("Link Component", module)
    .add("link contact", () => (
        <Link link="mailto:example@gmail.com" text="Contact" />
    ))
    .add("link more", () => <Link link="/username" text="More" />);
storiesOf("User Card", module).add("card mentor", () => (
    <UserCard
        user={{
            name: "MaryAnn Salvato",
            mentor: true,
            mentee: false,
        }}
        sections={[
            { title: "Looking to", text: "Help other women to get into tech" },
        ]}
    />
));
storiesOf("User Card", module).add("card mentee", () => (
    <UserCard
        user={{
            name: "MaryAnn Salvato",
            mentor: false,
            mentee: true,
        }}
        sections={[
            {
                title: "Looking for",
                text: "Sparring and helping with React code",
            },
        ]}
    />
));
storiesOf("User Card", module).add("card extended", () => (
    <UserCard
        user={{
            name: "MaryAnn Salvato",
            mentor: true,
            mentee: true,
        }}
        sections={[
            { title: "Looking to", text: "Help other women to get into tech" },
            {
                title: "Looking for",
                text: "Help with code and contacts in the field",
            },
            { title: "Experience", text: "Teacher" },
            {
                title: "Extra notes",
                text:
                    "I have been working as a teacher but want to enter the world of tech.",
            },
        ]}
    />
));
storiesOf("Signup Form", module)
    .addDecorator(withKnobs)
    .add("signup form", () => (
        <SignupForm
            name={text("Name", "Maryann Salvato")}
            email={text("Email", "")}
            password={text("Password", "")}
            onSubmit={action("Form submit")}
        />
    ));
