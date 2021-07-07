import React from "react";
import Input from "../input/input.component";
import Button from "../button/button.component";
import "./login-form.css";

const LoginForm = ({
    username,
    email,
    password,
    error,
    onSubmit,
}) => {
     return (
        <div className="login-form">
            {error ? (
                <div className="error">
                    <p>{error}</p>
                </div>
            ) : (
                <></>
            )}
            <h5>Log in</h5>
            <p>You need to Log In</p>
            <form
                onSubmit={(e) => {
                    e.preventDefault();
                    onSubmit({
                        name,
                        email,
                        password,
                    });
                }}
            >
                <div className="inputs">
                    <label>Name</label>
                    <Input
                        type="text"
                        name="username"
                        value={username}
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
                <Button type="submit">Continue</Button>
            </form>
        </div>
    );
};

export default LoginForm;
