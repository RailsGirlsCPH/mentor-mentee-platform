import React from "react";


function Homepage({ token }) {
    token && window.localStorage.setItem("access_token", token);
    return (
        <main>
            <h1>Welcome</h1>
            {(token || window.localStorage.getItem("access_token")) && (
                <p>User is registered and here now</p>
            )}
        {!token && !window.localStorage.getItem("access_token") ? (
                <h3>
                <br />
                <a href="/signup">Sign up</a>
                <br />
                <a href="/login">Login </a>
                    </h3>

        )
             : (
                <h3>
                    <a href="" onClick={() => window.localStorage.clear()}>
                        Log out of here
                    </a>
                </h3>
         )
       }
        </main>
    );
}
export default Homepage;
