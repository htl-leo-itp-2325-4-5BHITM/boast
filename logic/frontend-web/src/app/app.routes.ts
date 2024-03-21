import { Routes } from '@angular/router';
import {LogInPageComponent} from "./log-in-page/log-in-page.component";
import {PostComponent} from "./post/post.component";

export const routes: Routes = [
  { path: '', component: LogInPageComponent },
  { path: 'posts', component: PostComponent }
];
