import React from "react";
import Input from "../input/input.component";
import "./signup-form.css";

const SignupForm = ({ name, email, password, onSubmit }) => {
    return (
        <div className="signup-form">
            <h5>Sign up</h5>
            <p>You need to create an account</p>
            <div className="inputs">
                <label>Name</label>
                <Input type="text" name="name" required value={name} />
            </div>
            <div className="inputs">
                <label>Email</label>
                <Input type="email" name="email" required value={email} />
            </div>
            <div className="inputs">
                <label>Password</label>
                <Input
                    type="password"
                    name="password"
                    required
                    value={password}
                />
            </div>
            <button
                type="submit"
                onClick={() =>
                    onSubmit({
                        name,
                        email,
                        password,
                    })
                }
            >
                Continue
            </button>
        </div>
    );
};

export default SignupForm;
