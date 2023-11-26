# Structure of a Post

```json
{
   "postId": 1,
   "title": "",
   "definition": "",
   "creator": 1,
   "status": "",
   "typeInfo": {
      "type": ""
   },
   "postDetails": [
   ]
}
```

# Develop New Post Type

## Steps to build new Post Type and fully implement it:

- name is the name of the new PostType

**to develop new Model please look / copy the other code of other types and go threw all the steps!!**

### Model:

1. Add the ***{name}*** in the PostTypes Enum
2. Create new package model.post.type.{name} and do all changes in this package
3. Create class ***{name}***_Post extends Post implements PostType<***{name}***_PostDetails>
4. Create class ***{name}***_PostDetail extends PostDetail implements PostType<***{name}***_Post>
5. (Optional) Create post type specific data <br>***(example: answers in the Poll_Post -> Poll_PostAnswer)***
6. Implement necessary fields for the new post type, with getter & setter and default constructor
   <br> ***(NOTE: second constructor with super call needs to be implemented when DTO´s are finished)***

### DTO

Note: All fields that link to Entities are mapped with their ids (example: Long creator NOT BoastUser creator)

1. Create new package dto.post.type.{name} and do all changes in this package
2. Create class ***{name}***_PostDTO extends PostDTO
3. Create class ***{name}***_PostDetailDTO extends PostDetailDTO
4. Create class ***{name}***_TypeInfolDTO extends TypeInfoDTO
5. (Optional) Create post type specific dto -> **ONLY** use it as Field in TypeInfoDTO <br>
   ***(example: answerDTO in the Poll_TypeInfoDTO -> Poll_PostAnswerDTO)***
6. Implement necessary fields for the new post type, with getter & setter and default constructor
7. Implement a constructor with all the params from the super class and the post type specific ones
8. **GET BACK to the model** and implement the second constructor with the appropriate DTO and if needed Other Entities,
   in each class. <br> ***(example: POll_Post(Poll_PostDTO postDTO, BoastUser user) -> user for mapping the creator)***

### Repo

1. Implement method add ***{name}*** Post(***{name}***_PostDTO postDTO), build the ***{name}***_Post with all specific
   data and persist it
2. Implement method add ***{name}*** PostDetails(***{name}***_PostDetailDTO postDetailDTO), build the ***{name}***_
   PostDetail with all specific data and persist it
3. Implement in the switch of the getPost method a new case ***{name}*** that builds a ***{name}***_PostDTO with all the
   specific data

### Resource

1. Implement resources createPost/***{name}*** with body ***{name}***_PostDTO and call repo method
2. Implement resources addPostDetail/***{name}*** with body ***{name}***_PostDetailDTO and call repo method