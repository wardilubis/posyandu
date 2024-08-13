const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const app = express();

app.use(bodyParser.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'admin',
  database: 'posyandu',
});

db.connect(err => {
  if (err) {
    console.error('Database connection failed:', err.stack);
    return;
  }
  console.log('Connected to database.');
});

// User registration
app.post('/register', (req, res) => {
  const { name, phone_number, email, password } = req.body;  // Removed 'nik'
  const sql = 'INSERT INTO user (name, phone_number, email, password) VALUES (?, ?, ?, ?)';  // Updated query
  db.query(sql, [name, phone_number, email, password], (err, result) => {
    if (err) {
      console.error('Failed to register user:', err);
      return res.status(500).send('Failed to register user');  // Improved error message
    }
    res.send({ message: 'User registered successfully!' });
  });
});


// User login
app.post('/login', (req, res) => {
  const { email, password } = req.body;
  const sql = 'SELECT * FROM user WHERE email = ? AND password = ?';
  db.query(sql, [email, password], (err, results) => {
    if (err) {
      console.error('Failed to login:', err);
      return res.status(500).send(err);
    }
    if (results.length > 0) {
      res.send({ message: 'Login successful!', userId: results[0].id });
    } else {
      res.status(401).send({ message: 'Invalid email or password' });
    }
  });
});

app.post('/submit-ticket', (req, res) => {
  const { name, email, appointment_date, appointment_time, jenis_imunisasi, status } = req.body;

  const sql = 'INSERT INTO ticket (name, email, appointment_date, appointment_time, jenis_imunisasi, status) VALUES (?, ?, ?, ?, ?, ?)';
  
  db.query(sql, [name, email, appointment_date, appointment_time, jenis_imunisasi, status], (err, result) => {
    if (err) {
      console.error('Failed to create ticket:', err);
      return res.status(500).send({ message: 'Failed to create ticket' });
    }
    res.send({ message: 'Ticket created successfully!' });
  });
});

app.get('/tickets', (req, res) => {
  const sql = 'SELECT * FROM ticket ORDER BY appointment_date DESC, appointment_time DESC';
  
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Failed to fetch tickets:', err);
      return res.status(500).send({ message: 'Failed to fetch tickets' });
    }
    res.send(results);
  });
});

// Fetch user tickets
app.get('/tickets/:userId', (req, res) => {
  const userId = req.params.userId;
  const sql = 'SELECT * FROM ticket WHERE user_id = ? ORDER BY appointment_date DESC, appointment_time DESC';
  db.query(sql, [userId], (err, results) => {
    if (err) {
      console.error('Failed to fetch tickets:', err);
      return res.status(500).send(err);
    }
    res.send(results);
  });
});

// Fetch user data
app.get('/user/:id', (req, res) => {
  const userId = req.params.id;
  const sql = 'SELECT name, nik, email FROM user WHERE id = ?';
  db.query(sql, [userId], (err, results) => {
    if (err) {
      console.error('Failed to fetch user data:', err);
      return res.status(500).send(err);
    }
    if (results.length > 0) {
      res.send(results[0]);
    } else {
      res.status(404).send({ message: 'User not found' });
    }
  });
});

// Fetch all babies based on mother's name
app.get('/bayi/:ibu', (req, res) => {
  const ibu = req.params.ibu;
  const sql = 'SELECT * FROM bayi WHERE ibu = ?';
  db.query(sql, [ibu], (err, results) => {
    if (err) {
      console.error('Failed to fetch babies:', err);
      return res.status(500).send(err);
    }
    res.send(results);
  });
});

// Fetch all babies
app.get('/bayi', (req, res) => {
  const sql = 'SELECT * FROM bayi';
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Failed to fetch babies:', err);
      return res.status(500).send(err);
    }
    res.send(results);
  });
});

// Add a new baby record
app.post('/bayi', (req, res) => {
  const { nama, jenis_kelamin, tanggal_lahir, golongan_darah, ibu } = req.body;
  const sql = 'INSERT INTO bayi (nama, jenis_kelamin, tanggal_lahir, golongan_darah, ibu) VALUES (?, ?, ?, ?, ?)';
  db.query(sql, [nama, jenis_kelamin, tanggal_lahir, golongan_darah, ibu], (err, result) => {
    if (err) {
      console.error('Failed to add baby:', err);
      return res.status(500).send(err);
    }
    res.send({ message: 'Baby added successfully!' });
  });
});

// Fetch all immunization records
app.get('/imunisasi', (req, res) => {
  const sql = 'SELECT * FROM imunisasi';
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Failed to fetch immunization records:', err);
      return res.status(500).send(err);
    }
    res.send(results);
  });
});

// Add a new immunization record
app.post('/imunisasi', (req, res) => {
  const { nama_bayi, jenis_kelamin, tanggal_lahir, usia, berat_badan, tinggi_bayi } = req.body;

  const sql = 'INSERT INTO imunisasi (nama_bayi, jenis_kelamin, tanggal_lahir, usia, berat_badan, tinggi_bayi) VALUES (?, ?, ?, ?, ?, ?)';
  
  db.query(sql, [nama_bayi, jenis_kelamin, tanggal_lahir, usia, berat_badan, tinggi_bayi], (err, result) => {
    if (err) {
      console.error('Failed to add immunization record:', err);
      return res.status(500).send({ message: 'Failed to add immunization record' });
    }
    res.send({ message: 'Immunization record added successfully!' });
  });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
