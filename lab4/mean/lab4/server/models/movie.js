const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const movieSchema = new Schema({
    title: String,
    imdb: Number,
    publishedDate: String,
    shortDes: String,
    category: String,
    director: String,
    actors: Array
})

module.exports = mongoose.model('movie', movieSchema, 'movies')
