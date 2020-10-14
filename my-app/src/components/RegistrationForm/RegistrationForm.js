import React, { useState } from "react"
import axios from "axios"
import "./RegistrationForm.css"
import { withRouter } from "react-router-dom"

function RegistrationForm(props) {
    const [state, setState] = useState({
        username: "",
        email: "",
        password: "",
        confirmPassword: "",
        mentor: false,
        mentee: false,
        successMessage: null,
    })
    const handleChange = (e) => {
        const { id, value } = e.target
        setState((prevState) => ({
            ...prevState,
            [id]: value,
        }))
    }
    const handleInputChange = (e) => {
        const { id, value } = e.target
        const checked = e.target.checked
        setState((prevState) => ({
            ...prevState,
            [id]: checked,
        }))
    }
    const sendDetailsToServer = () => {
        if (state.email.length && state.password.length) {
            props.showError(null)
            const payload = {
                username: state.username,
                email: state.email,
                password: state.password,
                mentor: state.mentor,
                mentee: state.mentee,
            }
            axios
                .post("http://localhost:3000/api/v1/signup", payload)
                .then(function (response) {
                    if (response.status === 200) {
                        setState((prevState) => ({
                            ...prevState,
                            successMessage:
                                "Registration successful. Redirecting to home page..",
                        }))
                    } else {
                        props.showError("Some error ocurred")
                    }
                })
                .catch(function (error) {
                    console.log(error)
                })
        } else {
            props.showError("Please enter valid username and password")
        }
    }
    const handleSubmitClick = (e) => {
        e.preventDefault()
        if (state.password === state.confirmPassword) {
            sendDetailsToServer()
        } else {
            props.showError("Passwords do not match")
        }
    }
    return (
        <div className="card col-12 col-lg-4 login-card mt-2 hv-center">
            <form>
                <div className="form-group text-left">
                    <label htmlFor="exampleInputEmail1">Email address</label>
                    <input
                        type="email"
                        className="form-control"
                        id="email"
                        aria-describedby="emailHelp"
                        placeholder="Enter email"
                        value={state.email}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-group text-left">
                    <label htmlFor="exampleInputUsername1">Username</label>
                    <input
                        type="username"
                        className="form-control"
                        id="username"
                        placeholder="Enter Username"
                        value={state.confirmUsername}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-group text-left">
                    <label htmlFor="exampleInputMentor1">Mentor</label>
                    <input
                        type="checkbox"
                        className="form-control"
                        id="mentor"
                        checked={state.mentor}
                        onChange={handleInputChange}
                    />
                </div>
                <div className="form-group text-left">
                    <label htmlFor="exampleInputMentee1">Mentee</label>
                    <input
                        type="checkbox"
                        className="form-control"
                        id="mentee"
                        checked={state.mentee}
                        onChange={handleInputChange}
                    />
                </div>
                <div className="form-group text-left">
                    <label htmlFor="exampleInputPassword1">Password</label>
                    <input
                        type="password"
                        className="form-control"
                        id="password"
                        placeholder="Password"
                        value={state.password}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-group text-left">
                    <label htmlFor="exampleInputPassword1">
                        Confirm Password
                    </label>
                    <input
                        type="password"
                        className="form-control"
                        id="confirmPassword"
                        placeholder="Confirm Password"
                        value={state.confirmPassword}
                        onChange={handleChange}
                    />
                </div>
                <button
                    type="submit"
                    className="btn btn-primary"
                    onClick={handleSubmitClick}
                >
                    Register
                </button>
            </form>
            <div
                className="alert alert-success mt-2"
                style={{ display: state.successMessage ? "block" : "none" }}
                role="alert"
            >
                {state.successMessage}
            </div>
        </div>
    )
}

export default withRouter(RegistrationForm)
