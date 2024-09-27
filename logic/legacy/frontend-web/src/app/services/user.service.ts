import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {RequestService} from "./request.service";

export interface UserModel {
  userId: number,
  createdOn: string,
  isPublic: boolean,
  name: string,
  username: string,
  email: string,
  relationStatus: string,
  posts: Array<number>
}

export interface ProfileModel {
  userId: number,
  createdOn: String,
  name: String,
  username: String,
  follower: String,
  following: String,
  relationStatus: String,
  posts: Array<number>
}

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private _errorMessage = "";
  followers: UserModel[] = [];
  following: UserModel[] = [];

  constructor(private http: HttpClient,private router: Router, private requestService:RequestService) {
  }

  get errorMessage(): string {
    return this._errorMessage;
  }

  checkLogIn(username: string) {
    this.requestService.getUserByUsername(username).subscribe(user => {
      sessionStorage.setItem('userId', user.userId);
      sessionStorage.setItem('userName', user.username);
      this.router.navigateByUrl("posts");
    });
  }

  getFollowers(id: number): UserModel[] {
    this.followers = [];
    this.requestService.getFollowers(id).subscribe(ids => {
      ids.forEach((id: number) => {
        this.requestService.getUserById(id).subscribe(user => {
          this.followers.push(user);
        });
      });
    });
    return this.followers;
  }

  getFollowing(id: number): UserModel[] {
    this.following = [];
    this.requestService.getFollowing(id).subscribe(ids => {
      ids.forEach((id: number) => {
        this.requestService.getUserById(id).subscribe(user => {
          this.following.push(user);
        });
      });
    });
    return this.following;
  }

  //todo: getProfile Funktion fertigstellen -> profile in profile-page speichern -> Post - Follower - Following Anzahl anzeigen.
  getProfile(id: number) {
    this.requestService.getProfile(id).subscribe(profile => {
      console.log(profile);
    })
  }

}
