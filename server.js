import express from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.set('view engine', 'ejs');
app.use(express.static('public'));

app.get('/', async (req, res) => {
  res.render('home', { title: 'Home' });
});

app.get('/organizations', async (req, res) => {
  res.render('organizations', { title: 'Organizations' });
});

app.get('/projects', async (req, res) => {
  res.render('projects', { title: 'Projects' });
});

app.get('/categories', async (req, res) => {
  res.render('categories', { title: 'Categories' });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});