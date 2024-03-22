import { Injectable } from '@angular/core';
import {Observable} from "rxjs";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class RequestService {

  constructor(private http:HttpClient) { }

  //USER FUNCTIONS
  getUser(username: string): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/users/login/' + username);
  }

  //POST FUNCTIONS
  getAllPosts(): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/posts/');
  }

  getPostById(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/posts/' + id);
  }
}
