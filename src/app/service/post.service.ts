import {Injectable} from '@angular/core';
import {Observable} from "rxjs";
import { HttpClient} from '@angular/common/http';

export interface PostModel {
  _id: number
}
@Injectable({
  providedIn: 'root'
})
export class PostService {
  private _urlPostIds: string = 'https://www.boast.social/api/posts';
  private _urlPost: string = 'https://www.boast.social/api/posts/';

  constructor(private http: HttpClient) {}

  public getIds(): Observable<number[]> {
    console.log(this.http.get<number[]>(this._urlPostIds));
    return this.http.get<number[]>(this._urlPostIds);
  }
  public getPost(_id:number):Observable<PostModel[]> {
    return this.http.get<PostModel[]>(`${this._urlPost}${_id}`);
  }


}
