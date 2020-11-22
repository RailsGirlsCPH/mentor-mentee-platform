import React from "react";
import Input from "../input/input.component";
import Button from "../button/button.component";
import "./signup-form.css";

const SignupForm = ({
    name,
    email,
    password,
    mentor,
    mentee,
    error,
    onSubmit,
}) => {
    return (
        <div className="signup-form">
            {error ? (
                <div className="error">
                    <p>{error}</p>
                </div>
            ) : (
                <></>
            )}
            <h5>Sign up</h5>
            <p>You need to create an account</p>
            <form
                onSubmit={(e) => {
                    e.preventDefault();
                    onSubmit({
                        name,
                        email,
                        password,
                        mentor,
                        mentee,
                    });
                }}
            >
                <div className="inputs">
                    <label>Name</label>
                    <Input
                        type="text"
                        name="name"
                        value={name}
                        onChange={(e) => setName(e.target.value)}
                        required={true}
                    />
                </div>
                <div className="inputs">
                    <label>Email</label>
                    <Input
                        type="email"
                        name="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required={true}
                    />
                </div>
                <div className="inputs">
                    <label>Password</label>
                    <Input
                        type="password"
                        name="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required={true}
                        minLength={6}
                    />
                </div>
                <div className="checkboxes">
                    <p>Looking to be a:</p>
                    <div className="flex">
                        <div className="container">
                            <Input
                                type="checkbox"
                                name="Mentor"
                                value="Mentor"
                                checked={mentor && "checked"}
                                onChange={() => setMentor(!mentor)}
                            />
                            <label>Mentor</label>
                        </div>
                        <div className="container">
                            <Input
                                type="checkbox"
                                name="Mentee"
                                value="Mentee"
                                checked={mentee && "checked"}
                                onChange={() => setMentee(!mentee)}
                            />
                            <label>Mentee</label>
                        </div>
                    </div>
                </div>
                <Button type="submit">Continue</Button>
            </form>
        </div>
    );
};

export default SignupForm;
