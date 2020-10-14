import React, { useState } from "react";
import "./App.css";
import Header from "./components/Header/Header";
import RegistrationForm from "./components/RegistrationForm/RegistrationForm";

import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

function App() {
    const [title, updateTitle] = useState(null);
    const [errorMessage, updateErrorMessage] = useState(null);
    return (
        <Router>
            <div className="App">
                <Header title={title} />
                <div className="container d-flex align-items-center flex-column">
                    <Switch>
                        <Route path="/" exact={true}>
                            <RegistrationForm
                                showError={updateErrorMessage}
                                updateTitle={updateTitle}
                            />
                        </Route>
                        <Route path="/register">
                            <RegistrationForm
                                showError={updateErrorMessage}
                                updateTitle={updateTitle}
                            />
                        </Route>
                    </Switch>
                </div>
            </div>
        </Router>
    );
}

export default App;
