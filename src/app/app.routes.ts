import { Routes } from '@angular/router';
import {LogInPageComponent} from "./log-in-page/log-in-page.component";
import {PostsPageComponent} from "./posts-page/posts-page.component";
import {HomeComponent} from "./home/home.component";

export const routes: Routes = [
  { path: '', component: LogInPageComponent },
  { path: 'posts', component: PostsPageComponent },
  { path: 'home', component: HomeComponent}
];
