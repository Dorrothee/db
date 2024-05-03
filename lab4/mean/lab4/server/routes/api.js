const express = require('express');
const router = express.Router();
const mongoose = require('mongoose')
const Movie = require('../models/movie');

const db = "mongodb://localhost:27017/mean";
mongoose.Promise = global.Promise;


mongoose
  .connect(db)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.error("Connection error: ", err);
  });

router.get('/movies', async (req, res) => {
    try {
      console.log('Get request for all movies');
      const movies = await Movie.find({}).exec();
      res.json(movies);
    } catch (err) {
      console.error("Error retrieving movies: ", err);
      res.status(500).send("Error retrieving movies");
    }
});

router.get('/movies/:id', async (req, res) => {
    const movieId = req.params.id;
    try {
        console.log(`Get request for movie with ID: ${movieId}`);
        const movie = await Movie.findById(movieId).exec();
        if (movie) {
            res.json(movie);
        } else {
            res.status(404).send("Movie not found");
        }
    } catch (err) {
        console.error("Error retrieving movie: ", err);
        res.status(500).send("Error retrieving movie");
    }
});

router.post('/movie', async (req, res) => {
    const newMovie = new Movie({
        title: req.body.title,
        imdb: req.body.imdb,
        publishedDate: req.body.publishedDate,
        shortDes: req.body.shortDes,
        category: req.body.category,
        director: req.body.director,
        actors: req.body.actors,
    });

    try {
        console.log('Post a new movie');
        const insertedMovie = await newMovie.save();
        res.json(insertedMovie);
    } catch (err) {
        console.error("Error posting movie: ", err);
        res.status(500).send("Error posting movie");
    }
});

router.put('/movie/:id', async (req, res) => {
    console.log('Update a movie');
    const movieId = req.params.id;

    try {
        const updatedMovie = await Movie.findByIdAndUpdate(
            movieId,
            {
                $set: {
                    title: req.body.title,
                    imdb: req.body.imdb,
                    publishedDate: req.body.publishedDate,
                    shortDes: req.body.shortDes,
                    category: req.body.category,
                    director: req.body.director,
                    actors: req.body.actors,
                },
            },
            {
                new: true,
                runValidators: true,
            }
        );

        if (!updatedMovie) {
            return res.status(404).json({ error: 'Movie not found' });
        }

        res.json(updatedMovie);
    } catch (err) {
        console.error("Error updating movie:", err);
        res.status(500).json({ error: "Error updating movie" });
    }
});

router.delete('/movies/:id', async (req, res) => {
    console.log('Deleting a movie');
    const movieId = req.params.id;

    try {
        const deletedMovie = await Movie.findByIdAndDelete(movieId);

        if (!deletedMovie) {
            return res.status(404).json({ error: 'Movie not found' });
        }

        res.status(200).json({ message: 'Movie deleted successfully', movie: deletedMovie });
    } catch (err) {
        console.error("Error deleting movie:", err);
        res.status(500).json({ error: "Error deleting movie" });
    }
});

module.exports = router;