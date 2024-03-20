import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";

export interface UserModel {
  id: number;
}

@Injectable({
  providedIn: 'root'
})
export class UserService {

  //newUser: UserModel;
  constructor(private http: HttpClient) {
  }

  getUser(username: string): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/users/login/' + username);
  }
  checkLogIn(username: string) {
    //todo: #2 Hier soll der Request aufn Server passieren.
    //todo: #3 Durch die 2 Methoden entsteht praktisch der LogIn -> Weiterleiten auf andere Page die Posts anzeigt (todo #4)
    /*
    this.getUser(username).subscribe(user => {
      console.log(user);
      this.newUser.id = user.id;
      return this.newUser;
    });

     */
  }
}
