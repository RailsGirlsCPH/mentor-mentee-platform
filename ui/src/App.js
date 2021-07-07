import React, { useState } from "react";
import "./index.css";
import SignupForm from "./containers/signup/signup-form";
import LoginForm from "./containers/login/login-form";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import Homepage from "./containers/homepage/homepage";

function App() {
    const [token, setToken] = useState(null);
    return (
        <Router>
            <div className="app">
                <div className="main">
                    <Switch>
                        <Route path="/" exact={true}>
                            <Homepage token={token} />
                        //</Route>
                        //<Route path="/signup">
                        //    <SignupForm setToken={setToken} />
                        // </Route>
                         <Route path="/login">
                         <LoginForm setToken={setToken} />
                         </Route>
                    </Switch>
                </div>
            </div>
        </Router>
    );
}

export default App;

