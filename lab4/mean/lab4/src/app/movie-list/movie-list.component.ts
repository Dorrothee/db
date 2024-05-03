import { Component, OnInit, EventEmitter } from '@angular/core';
import { Movie } from '../movie';

@Component({
  selector: 'movie-list',
  templateUrl: './movie-list.component.html',
  styleUrls: ['./movie-list.component.css'],
  inputs: ['movies'],
  outputs: ['SelectMovie']
})
export class MovieListComponent implements OnInit {
  movies: Movie[] = [];

  public SelectMovie = new EventEmitter();

  constructor() {}

  ngOnInit() {

  }

  onSelect(mv: Movie){
    this.SelectMovie.emit(mv);
  }
}
