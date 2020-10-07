import React, {useState, useEffect} from 'react';
import './App.css';

function App() {

    useEffect(() => {
        const requestOptions = {
            method: 'POST',
            mode: 'cors',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
	              "username": "ashley8",
	              "email": "ashley8@email.com",
	              "password": "foobar",
                "mentor": "true",
                "mentee": "true"
            }) };
        fetch('http://localhost:3000/api/v1/signup', requestOptions)
              .then(response => response.json())
            .then(data => console.log(data))
            .catch(error => console.log(error));
             });
  return (
    <div>
          RailsGirls Mentor mentee platform, we can update on our machine in October.  we can make changes boo yah! Or can we though

    </div>
  );
}

export default App;
