
const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Parse incoming form data
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Serve static files
app.use('/style', express.static(path.join(__dirname, '../style')));
app.use('/images', express.static(path.join(__dirname, '../images')));

// Home page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../Pages/index.html'));
});

// Other pages
app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, '../Pages/login.html'));
});

app.get('/register', (req, res) => {
    res.sendFile(path.join(__dirname, '../Pages/register.html'));
});

app.get('/cart', (req, res) => {
    res.sendFile(path.join(__dirname, '../Pages/cart.html'));
});

app.get('/adminLogin', (req, res) => {
    res.sendFile(path.join(__dirname, '../Pages/adminLogin.html'));
});

app.get('/userView', (req, res) => {
    res.sendFile(path.join(__dirname, '../Pages/userView.html'));
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
});
