# Structure of a Post

```json
{
   "postId": 0,
   "createdOn": "2024-01-01",
   "title": "string",
   "definition": "string",
   "creatorId": 0,
   "creatorName": "string",
   "status": "string",
   "type": "string",
   "typeInfo": {
      /* TYPESPECIFIC INFOs (Like PollAnswers)*/
   },
   "postDetails": [
      {
         "postDetailsId": 0,
         "createdOn": "2024-01-01",
         "creatorId": 0,
         "creatorName": "string",
         "postId": 0
         /* TYPESPECIFIC INFOs (Like poll_answerId)*/
      }
   ]
}
```

# Develop New Post Type

## Steps to build new Post Type and fully implement it (only backend):

- name is the name of the new PostType

**to develop new Model please look / copy the code of a already developed (similar) type and go threw all these steps!!**

### Model:

1. Add the ***{name}*** in the PostTypes Enum
2. Create new package model.post.type.{name} and do all changes in this package
3. Create class ***{name}***_Post extends Post implements PostType<***{name}***_PostDetails>
4. Create class ***{name}***_PostDetail extends PostDetail implements PostType<***{name}***_Post>
5. (Optional) Create post type specific data <br>***(example: answers in the Poll_Post -> Poll_PostAnswer)***
6. Implement necessary fields for the new post type, with getter & setter and default constructor
   <br> ***(NOTE: second constructor with super call needs to be implemented once the specific DTO´s are finished)***

### DTO

Note: All fields that link to Entities are mapped with their ids (example: Long creatorId **NOT** BoastUser creator)

1. Create new package dto.post.type.{name} and do all changes in this package
2. Create class ***{name}***_PostDTO extends PostDTO
3. Create class ***{name}***_PostDetailDTO extends PostDetailDTO
4. Create class ***{name}***_TypeInfolDTO extends TypeInfoDTO
5. (Optional) Create post type specific dto -> **ONLY** use it as Field in the **type specific** ***{name}***_TypeInfoDTO <br>
   ***(example: answerDTO in the Poll_TypeInfoDTO -> Poll_PostAnswerDTO)***
6. Implement necessary fields for the new post type, with getter & setter and default constructor
7. Implement a constructor with all the params from the super class and the post type specific ones
8. **BACK to the model** and implement the second constructor with the appropriate DTO and if needed other Entities,
   in each class. <br> ***(example: POll_Post(Poll_PostDTO postDTO, BoastUser user) -> user for mapping the creator)***

### Repo

NOTE: check already implemented methods for reference, use //<editor-fold desc="**{name}**">...//</editor-fold> for clean code in IDEA

#### In the PostRepository
1. Implement method create ***{name}*** Post(***{name}***_PostDTO postDTO), build the ***{name}***_Post with all specific
   data and persist it
2. Implement a new case ***{name}*** in the switch of the getPost method, that builds a ***{name}***_PostDTO with all the
      specific data

#### In the PostDetailRepository
1. Implement method add ***{name}*** PostDetails(***{name}***_PostDetailDTO postDetailDTO), build the ***{name}***_
   PostDetail with all specific data and persist it

### Resource

NOTE: surround all method logic with try catch and return Response (200 if ok, 422 if data was invalid)

#### In the PostResource
1. Implement resource with HTTPMethod POST posts/***{name}*** with body ***{name}***_PostDTO and call repo method

#### In the PostResource
1. Implement resource with HTTPMethod POST post-details/***{name}*** with body ***{name}***_PostDetailDTO and call repo method