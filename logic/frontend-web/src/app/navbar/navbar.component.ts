import { Component } from '@angular/core';
import {Router} from "@angular/router";

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {

  activeColor:String = '#fff';
  notactiveColor:String = '#a3a3a3';
  homeColor:String = '#fff';
  postsColor:String = '#fff';
  profileUrl: String = '../../assets/person.crop.circle.fill.png';
  imageWidth: String = '40vw';

  constructor(private router: Router) {
    this.activePage()
  }

  isLoggedIn() {
    if(this.router.url == '/profile') {
      sessionStorage.removeItem('userId');
      sessionStorage.removeItem('userName');
      this.router.navigateByUrl('login');
    }
    if(sessionStorage.getItem('userId') != null && sessionStorage.getItem('userName') != null) {
      this.router.navigateByUrl("profile");
    }else {
      this.router.navigateByUrl("login");
    }
  }

  activePage() {

    if(this.router.url == "/home") {
      this.homeColor = '#fff';
      this.postsColor = '#a3a3a3';
    } else if(this.router.url == "/posts"){
      this.homeColor = '#a3a3a3';
      this.postsColor = '#fff';
    } else if(this.router.url == "/profile") {
      this.postsColor = '#a3a3a3';
      this.homeColor = '#a3a3a3';
    }
    if(this.router.url == "/profile") {
      this.profileUrl = '../../assets/logout.svg';
      this.imageWidth = '35vw';
    } else {
      this.profileUrl = '../../assets/person.crop.circle.fill.png';
      this.imageWidth = '40vw';
    }
  }
}
