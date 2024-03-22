import { Component } from '@angular/core';
import {UserService} from "../services/user.service";
import {FormsModule} from "@angular/forms";

@Component({
  selector: 'app-log-in-page',
  standalone: true,
  imports: [
    FormsModule
  ],
  templateUrl: './log-in-page.component.html',
  styleUrl: './log-in-page.component.css'
})
export class LogInPageComponent {

  username: string = '';

  constructor(protected userService: UserService) {
  }

  logIn(username: string){
    this.userService.checkLogIn(username);
  }
}
