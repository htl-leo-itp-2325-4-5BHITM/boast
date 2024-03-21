import { Component } from '@angular/core';
import {PostService} from "../service/post.service";
import {UserService} from "../service/user.service";
import {FormsModule} from "@angular/forms";
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import {readBooleanType} from "@angular/compiler-cli/src/ngtsc/metadata/src/util";
import {Observable} from "rxjs";

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
  errorOpacity: string = '';

  constructor(protected userService: UserService) {
  }

  logIn(username: string){
    //todo: #1 logIn() wird im html aufgerufen und prüft ob es den gegebenen User gibt. Dafür muss in dieser Methode auf user.service zugegriffen werden.
    this.userService.checkLogIn(username);
  }
}
