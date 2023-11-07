const url = 'http://localhost:8080/post/addPost';

const headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YourAuthToken',
};
function uploadChallenge() {
    let creator = document.getElementById("creator").value;
    let description = document.getElementById("description").value;
    let title = document.getElementById("title").value;
    let amountPeople = document.getElementById("amountPeople").value;
    let postDetails = [];
    let winner = "";
    for (let i = 0; i < amountPeople; i++) {
        let name = document.getElementById("name" + i).value;
        let result = document.getElementById("result" + i).value;
        if (document.getElementById("winner" + i).checked) {
            winner = name;
        }
        postDetails.push({"creator": name, "bet": result});
    }
    let json = {
        "creator": creator,
        "definition": description,
        "postDetails": postDetails,
        "title": title,
        "winner": winner
    }

    console.log(JSON.stringify(json));

    fetch(url, {
        method: 'POST',
        headers: headers,
        body: JSON.stringify(json),
    })
        .then((response) => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
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


    // Validation
    const warning = document.getElementById("warning");
    if (creator.trim() == "" || description.trim() == "" || title.trim() == "" || amountPeople < 2) {
        warning.innerHTML = `<div class="formError">
                                <p> Please fill out every inputfield. </p>
                            </div>`
    } else {
        warning.innerHTML = "";

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
                                    <input type="text" id="name${i}" required>
                                    <label for="result">Result:</label>
                                    <input type="text" id="result${i}" required>
                                    <label for="winner">Winner: </label>
                                    <input type="radio" name="winnerBox" id="winner${i}" required>
                                    <br>`;
        }
        outputDiv.innerHTML += `<button type="button" onclick="uploadChallenge()">Save</button></div><br><br>`;
    }
}