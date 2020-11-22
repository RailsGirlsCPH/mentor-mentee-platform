import React from "react";

function Homepage({ token }) {
    token && window.localStorage.setItem("access_token", token);
    return (
        <main>
            <h1>Homepage</h1>
            {(token || window.localStorage.getItem("access_token")) && (
                <p>User is registered</p>
            )}
            {!token && !window.localStorage.getItem("access_token") ? (
                <h2>
                    <a href="/signup">Sign up</a>
                </h2>
            ) : (
                <h2>
                    <a href="" onClick={() => window.localStorage.clear()}>
                        Log out
                    </a>
                </h2>
            )}
        </main>
    );
}

export default Homepage;
