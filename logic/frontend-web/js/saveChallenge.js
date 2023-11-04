const url = 'http://localhost:8080';

const headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YourAuthToken',
};
function uploadChallenge() {
    fetch(url, {
        method: 'POST',
        headers: headers,
    })
        .then((response) => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then((data) => {
            console.log('Data:', data);
        })
        .catch((error) => {
            console.error('Fetch Error:', error);
        });
}

function showData() {
    // Get the values entered by the user
    let creator = document.getElementById("creator").value;
    let description = document.getElementById("description").value;
    let title = document.getElementById("title").value;
    let amountPeople = document.getElementById("amountPeople").value;

    // Display the entered data
    const outputDiv = document.getElementById("output");
    outputDiv.innerHTML += `<div class="challenge">
                                    <p><strong>Title:</strong> ${title}</p>
                                    <p><strong>Creator:</strong> ${creator}</p>
                                    <p><strong>Description:</strong> ${description}</p>
                                    <br>
                                    <h2>Contestants: </h2>`;
    for (let i = 0; i < amountPeople; i++) {
        outputDiv.innerHTML += `<label for="name">Name:</label>
                                    <input type="text" id="name">
                                    <label for="result">Result:</label>
                                    <input type="text" id="result">
                                    <label for="winner">Winner: </label>
                                    <input type="radio" name="winnerBox" id="winner">
                                    <br>`;
    }
    outputDiv.innerHTML += `<button type="button">Save</button></div><br><br>`;
}

