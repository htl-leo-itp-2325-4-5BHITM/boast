import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {RequestService} from "./request.service";

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private _errorMessage = ""

  constructor(private http: HttpClient,private router: Router, private requestService:RequestService) {
  }

  get errorMessage(): string {
    return this._errorMessage;
  }

  checkLogIn(username: string) {

    this.requestService.getUser(username).subscribe(user => {
      console.log(user)
      sessionStorage.setItem('User', user);
      this.router.navigateByUrl("posts")
    });
  }
}
