import {Component, Input} from '@angular/core';
import {UserModel, UserService} from "../services/user.service";
import {NgForOf} from "@angular/common";

@Component({
  selector: 'app-user',
  standalone: true,
  imports: [
    NgForOf
  ],
  templateUrl: './user.component.html',
  styleUrl: './user.component.css'
})
export class UserComponent {

  private _users: UserModel[] = [];
  private _id: number = 0;
  @Input() modifier: string = "";


  constructor(private userService: UserService) {
  }

  ngOnInit(): void {
    this._id = Number(sessionStorage.getItem('userId'));
    if(this.modifier == 'following') {
      this._users = this.userService.getFollowing(this._id);
    } else if (this.modifier == 'follower') {
      this._users = this.userService.getFollowers(this._id);
    }
  }

  get users(): UserModel[] {
    return this._users;
  }
}
