import {Injectable} from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {Observable} from "rxjs";

export interface PostModel {
  _id: number
}
@Injectable({
  providedIn: 'root'
})
export class PostService {
  static _urlPostIds: string = 'https://www.boast.social/api/posts';
  static _urlPost: string = 'https://www.boast.social/api/posts/';

  constructor(private http: HttpClient) {}

  getIds():Observable<number[]> {
    return this.http.get<number[]>(PostService._urlPostIds);
  }
  getPost(_id:number):Observable<PostModel[]> {
    return this.http.get<PostModel[]>(`${PostService._urlPost}${_id}`);
  }


}
