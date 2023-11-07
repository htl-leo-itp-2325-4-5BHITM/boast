const url = 'http://localhost:8080/post/getPostsAsList';


const headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YourAuthToken',
};

// Create a Fetch request
fetch(url, {
    method: 'GET',
    headers: headers,
})
    .then((response) => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then((data) => {
        console.log('Data:', data)
        // Display the data in the browser
        for(let i = 0; i < data.length; i++) {
            // initialising all bets in the given response
            let bet = "";
            for (let j= 0; j < data[i].postDetails.length; j++) {
                bet += `<li>${data[i]["postDetails"][j]["bet"]}, ${data[i]["postDetails"][j]["creator"]}</li>`
            }
            document.getElementById("output").innerHTML +=
                `<br><hr>
                <h1>${data[i].creator}</h1>
                <h2>${data[i].title}</h2>
                <p>${data[i].definition}</p>
                <ul>${bet}</ul>
                <h2>Winner: ${data[i].winner}</h2>
                <hr>`;

        }
    })
    .catch((error) => {
        console.error('Fetch Error:', error);
    });
