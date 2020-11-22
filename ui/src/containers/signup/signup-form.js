import React, { useState } from "react";
import axios from "axios";
import Input from "../../components/input/input.component";
import Button from "../../components/button/button.component";
import "../../components/signupForm/signup-form.css";
import { withRouter, useHistory } from "react-router-dom";

function SignupForm({ setToken }) {
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
            .post("http://localhost:3000/api/v1/signup", payload)
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
        if (!mentor && !mentee) {
            setErrorCheckbox("Please choose either mentor or mentee");
            return;
        }
        if (error === "") sendDetailsToServer(input);
    };
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
                <div className="checkboxes">
                    <p>Looking to be a:</p>
                    <p>{errorCheckbox}</p>
                    <div className="flex">
                        <div className="container">
                            <Input
                                type="checkbox"
                                name="Mentor"
                                value={mentor}
                                onChange={() => {
                                    setMentor(!mentor);
                                    setErrorCheckbox("");
                                }}
                            />
                            <label>Mentor</label>
                        </div>
                        <div className="container">
                            <Input
                                type="checkbox"
                                name="Mentee"
                                value={mentee}
                                onChange={() => {
                                    setMentee(!mentee);
                                    setErrorCheckbox("");
                                }}
                            />
                            <label>Mentee</label>
                        </div>
                    </div>
                </div>
                <Button type="submit">Continue</Button>
            </form>
        </div>
    );
}

export default withRouter(SignupForm);
