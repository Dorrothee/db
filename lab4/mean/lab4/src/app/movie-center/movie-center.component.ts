import { Component, OnInit } from '@angular/core';
import { Movie } from '../movie';
import { MovieService } from '../movie.service';
import { Observable, catchError, tap, throwError } from 'rxjs';

@Component({
  selector: 'app-movie-center',
  templateUrl: './movie-center.component.html',
  styleUrls: ['./movie-center.component.css'],
  providers: [MovieService]
})
export class MovieCenterComponent implements OnInit {
  
  movies: Movie[] = [];
  selectedMovie: Movie | null = null;
  hidenewMovie: boolean = true;


  constructor(private movieService: MovieService) {}
  
  ngOnInit(): void {
    this.fetchMovies(); 
  }

  fetchMovies(): void {
    this.movieService.getMovies()
      .subscribe({
        next: (resMovieData: Movie[]) => { 
          this.movies = resMovieData; 
        },
        error: (error) => {
          console.error('Error fetching movies:', error);
        },
      });
  }

  onSelectMovie(movie: Movie): void {
    this.selectedMovie = movie;
    this.hidenewMovie = false;
    console.log('Selected Movie:', this.selectedMovie);
  }

  onSubmitAddMovie(movie: Movie)
  {
    this.movieService.addMovie(movie)
    .subscribe(resNewMovie => {
      this.movies.push(resNewMovie);
      this.selectedMovie = resNewMovie;
      this.hidenewMovie = false;
    });
  }

  onUpdateMovieEvent(movie: Movie) {
    this.movieService.updateMovie(movie)
      .subscribe(
        (resUpdatedMovie) => {
          const index = this.movies.findIndex(m => m._id === resUpdatedMovie._id);
          if (index >= 0) {
            this.movies[index] = resUpdatedMovie;
          }

          this.selectedMovie = null;
        },
        (error) => {
          console.error("Error updating movie:", error);
        }
      );
  }
  
  onDeleteMovieEvent(movie: Movie): void {
    this.movieService.deleteMovie(movie) 
      .pipe(
        tap(() => {
          this.movies = this.movies.filter(m => m._id !== movie._id);
          this.selectedMovie = null;
        }),
        catchError((error) => {
          console.error('Failed to delete movie:', error);
          alert('Failed to delete movie. Please try again later.');
          return throwError(() => new Error('Failed to delete movie.'));
        })
      )
      .subscribe();
}


  private handleError(error: any): Observable<never> {
    console.error('Error deleting movie:', error)
    return throwError(() => new Error('Error deleting movie.'))
  }
  

  newMovie(){
    this.hidenewMovie = true;
  }
}
