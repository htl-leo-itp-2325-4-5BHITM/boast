import { Component } from '@angular/core';
import {PostModel, PostService} from "../service/post.service";
import {NgFor, NgForOf} from "@angular/common";

@Component({
  selector: 'app-post',
  standalone: true,
  imports: [
    NgForOf
  ],
  templateUrl: './post.component.html',
  styleUrl: './post.component.css'
})
export class PostComponent {

  constructor(public postService: PostService) {
  }

  ngOnInit(): PostModel[] {
    this.postService.getIds().subscribe((ids) => {
      this.postService.ids = ids;
    })

    let createdPost:PostModel;
    for(let i = 0; i < this.postService.ids.length; i++) {
      this.postService.getPost(i+1).subscribe((post) => {
        let createdPost: PostModel = {
          creatorName: post.creatorName,
          id: post.id,
          status: post.status,
          createdOn: post.createdOn,
          title: post.title,
          definition: post.definition
        };
        this.postService.posts[i] = createdPost;
      })
    }
    console.log(this.postService.posts);
    return this.postService.posts;
  }

}
