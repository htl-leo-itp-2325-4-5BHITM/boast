import { Routes } from '@angular/router';
import {LogInPageComponent} from "./log-in-page/log-in-page.component";
import {PostsPageComponent} from "./posts-page/posts-page.component";
import {HomeComponent} from "./home/home.component";
import {ProfilePageComponent} from "./profile-page/profile-page.component";

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'home', component: HomeComponent},
  { path: 'login', component: LogInPageComponent },
  { path: 'posts', component: PostsPageComponent },
  { path: 'profile', component: ProfilePageComponent}
];
