import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';
import { Movie } from './movie';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class MovieService {
  private _getUrl = '/api/movies';
  private _postUrl = '/api/movie';
  private _putUrl = '/api/movie';
  private _deleteUrl = '/api/movies';

  constructor(private _http: HttpClient) {}

  getMovies(): Observable<Movie[]> {
    return this._http.get<Movie[]>(this._getUrl) 
      .pipe(
        map((data) => data),
        catchError(this.handleError) 
      );
  }

  addMovie(movie: Movie): Observable<Movie> {
    return this._http.post<Movie>(this._postUrl, movie)
      .pipe(
        catchError(this.handleError)
      );
  }

  updateMovie(movie: Movie): Observable<Movie> {
    if (!movie._id) {
      throw new Error("Movie must have an ID to be updated.");
    }

    const updateUrl = `${this._putUrl}/${movie._id}`;

    return this._http.put<Movie>(updateUrl, movie)
      .pipe(
        catchError((error) => {
          console.error("Error updating movie:", error);
          return throwError(error);
        })
      );
  }

  deleteMovie(movie: Movie): Observable<void> { 
    const deleteUrl = `${this._deleteUrl}/${movie._id}`; 

    return this._http.delete<void>(deleteUrl) 
      .pipe(
        tap(() => console.log(`Deleting movie with ID: ${movie._id}`)),
        catchError((error) => {
          console.error('Error deleting movie:', error);
          return throwError(() => new Error('Error deleting movie.')); 
        })
      );
}



  private handleError(error: any): Observable<never> { 
    console.error('An error occurred:', error);
    return throwError(error.message || 'Server error');
  }
}
