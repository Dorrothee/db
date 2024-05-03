import { Component, EventEmitter, OnInit } from '@angular/core';
import { Movie } from '../movie';

@Component({
  selector: 'movie-detail',
  templateUrl: './movie-detail.component.html',
  styleUrls: ['./movie-detail.component.css'],
  inputs: ['movie'],
  outputs: ['updateMovieEvent', 'deleteMovieEvent']
})
export class MovieDetailComponent implements OnInit {

  movie: Movie = new Movie;

  public editTitle: boolean = false;
  public updateMovieEvent = new EventEmitter();
  public deleteMovieEvent = new EventEmitter();

  constructor() {}

  ngOnInit() {

  }

  ngOnChanges() {
    this.editTitle = false;
  }
  onTitleClick() {
    this.editTitle = true;
  }

  updateMovie() {
    this.updateMovieEvent.emit(this.movie);
  }

  deleteMovie() {
    this.deleteMovieEvent.emit(this.movie);
  }

}
