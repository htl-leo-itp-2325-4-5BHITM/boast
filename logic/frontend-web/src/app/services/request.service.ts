import { Injectable } from '@angular/core';
import {Observable} from "rxjs";
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {ProfileModel} from "./user.service";

@Injectable({
  providedIn: 'root'
})
export class RequestService {

  headers: HttpHeaders = new HttpHeaders({
    'reqUserId': Number(sessionStorage.getItem('userId'))
  });



  constructor(private http:HttpClient) { }

  //USER FUNCTIONS
  getUserByUsername(username: string): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/users/login/' + username);
  }
  getUserById(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/users/' + id);
  }

  getUserAndPostsById(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/users/profile/' + id, {headers:this.headers});
  }

  getProfile(id: number): Observable<ProfileModel> {
    return this.http.get<any>('https://www.boast.social/api/profile/' + id, {headers:this.headers});
  }

  //returns number[]
  getFollowers(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/relations/followers/' + id);
  }

  //returns number[]
  getFollowing(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/relations/following/' + id);
  }

  //POST FUNCTIONS
  //returns number[]
  getAllPosts(): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/posts/');
  }

  getPostsOfFriends(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/posts/friends/' + id);
  }

  getPostById(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/posts/' + id);
  }

}
