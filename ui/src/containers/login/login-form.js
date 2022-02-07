import React, { useState } from "react";
import axios from "axios";
import Input from "../../components/input/input.component";
import Button from "../../components/button/button.component";
import "../../components/loginForm/login-form.css";
import { withRouter, useHistory } from "react-router-dom";

function LoginForm({ setToken }) {
    const [email, setEmail] = useState("");
    const [name, setName] = useState("");
    const [password, setPassword] = useState("");
    const [mentor, setMentor] = useState(false);
    const [mentee, setMentee] = useState(false);
    const [errorCheckbox, setErrorCheckbox] = useState("");
    const [error, setError] = useState("");
    let history = useHistory();

    const sendDetailsToServer = () => {
        const payload = {
            username: name,
            email,
            password,
            mentor,
            mentee,
        };
        axios
            .post("http://localhost:3000/auth/login", payload)
            .then((response) => {
                if (response.status === 200) {
                    setToken(response.data.auth_token);
                    history.push("/");
                }
            })
            .catch((error) => {
                setError(error.response.data.message);
            });
    };
    const handleSubmitClick = (input) => {
        input.preventDefault();
        if (error === "") sendDetailsToServer(input);
    };
    return (
        <div className="login-form">
            {error ? (
                <div className="error">
                    <p>{error}</p>
                </div>
            ) : (
                <></>
            )}
            <h5>Login</h5>
            <p>Login to your existing account</p>
            <form
                onSubmit={(input) => handleSubmitClick(input)}
                onChange={() => setError("")}
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
                <Button type="submit">Continue</Button>
            </form>
        </div>
    );
}

export default withRouter(LoginForm);
