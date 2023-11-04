const url = 'http://localhost:8080';

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
        console.log('Data:', data);
    })
    .catch((error) => {
        console.error('Fetch Error:', error);
    });
