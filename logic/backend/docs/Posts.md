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
   "typeInfo": { /* OPTIONAL: TYPESPECIFIC INFOs (Like PollAnswers)*/
      
   },
   "postDetails": [
      {
         "postDetailsId": 0,
         "createdOn": "2024-01-01",
         "creatorId": 0,
         "creatorName": "string",
         "postId": 0
         /* TYPESPECIFIC INFOs (Like poll_answerId or text)*/
      }
   ]
}
```

# Develop New Post Type

## Steps to build new Post Type and fully implement it (only backend):

- ***{name}*** is the name of the new PostType
- To develop new Model please **look / copy** the code of a already developed (similar) type and go threw all these steps**
- **While going threw the steps there can be a lot of errors** which will be automatically fixed when finished with all steps**

### Model:

Note: All classes need to be a @Entity

1. Add the ***{name}*** in the PostTypes Enum
2. Create new package model.post.type.{name} and do all changes in this package
3. Create class ***{name}***_Post extends Post implements PostType_Interface<***{name}***_PostDetails>
4. Create class ***{name}***_PostDetail extends PostDetail implements PostDetailType_Interface<***{name}***_Post>
5. (Optional) Create post type specific data <br>***(example: answers in the Poll_Post -> Poll_PostAnswer)***
6. Implement necessary fields for the new post type, with getter & setter and default constructor
   <br> ***(NOTE: second constructor with super call needs to be implemented once the specific DTO´s are finished)***

```java
// {name}_Post

@Entity
public class {name}_Post extends Post implements PostType_Interface<{name}_PostDetail> {

    // OPTIONAL: specific Data like pollAnswers, getter and setter (if list, add and remove) needed

    @OneToMany(mappedBy = "post", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<{name}_PostDetail> postDetails;

    public {name}_Post({name}_PostDTO postDTO, BoastUser user) {
        super(postDTO.createdOnDate(),
                postDTO.getTitle(),
                postDTO.getDefinition(),
                user,
                Status.valueOf(postDTO.getStatus()),
                PostType.{name});
    }

    public {name}_Post() {}

    @Override
    public List<{name}_PostDetail> getPostDetails() {
        return postDetails;
    }

    @Override
    public void setPostDetails(List<{name}_PostDetail> postDetails) {
        this.postDetails = postDetails;
    }

    @Override
    public void addPostDetail({name}_PostDetail postDetail) {
        postDetails.add(postDetail);
    }

    @Override
    public void removePostDetail({name}_PostDetail postDetail) {
        this.postDetails.remove(postDetail);
    }
}

// {name}_PostDetail

@Entity
public class {name}_PostDetail extends PostDetail implements PostDetailType_Interface<{name}_Post> {
    
    // OPTIONAL: specific Data like pollAnswer or text, getter and setter needed

   @ManyToOne
   @JoinColumn(name = "postId")
   {name}_Post post;

   public {name}_PostDetail({name}_PostDetailDTO postDetailDTO, BoastUser user, Text_Post post, String text /* OPTIONAL: specific Data */) {
      super(postDetailDTO.createdOnDate(), user);
      this.post = post;
      /* OPTIONAL: specific Data */
   }

   public {name}_PostDetail() {}

   @Override
   public {name}_Post getPost() {
      return post;
   }

   @Override
   public void setPost({name}_Post post) {
      this.post = post;
   }
}
```


### DTO

Note: All fields that link to Entities are mapped with their ids (example: Long creatorId **NOT** BoastUser creator)

1. Create new package dto.post.type.{name} and do all changes in this package
2. Create class ***{name}***_PostDTO extends PostDTO implements PostTypeDTO_Interface<***{name}***_PostDetailDTO>
3. Create class ***{name}***_PostDetailDTO extends PostDetailDTO
4. (Optional if typeInfo Data is needed) Create class ***{name}***_TypeInfolDTO extends TypeInfoDTO
   <br> Create post type specific dto -> **ONLY** use it as Field in the **type specific** ***{name}***_TypeInfoDTO <br>
   ***(example: answerDTO in the Poll_TypeInfoDTO -> Poll_PostAnswerDTO)***
6. Implement necessary fields for the new post type, with getter & setter and default constructor
7. Implement a constructor with all the params from the super class and the post type specific ones
8. **BACK to the model** and implement the second constructor with the appropriate DTO and if needed other Entities,
   in each class. <br> ***(example: POll_Post(Poll_PostDTO postDTO, BoastUser user) -> user for mapping the creator)***

```java
CLASS: {name}_PostDTO

public class {name}_PostDTO extends PostDTO implements PostTypeDTO_Interface<{name}_PostDetailDTO> {
   List<{name}_PostDetailDTO> postDetails;

   public {name}_PostDTO(Long postId, Date createdOn, String title, String definition, Long creator, String creatorName, String status, String type, List<Text_PostDetailDTO> postDetails) {
      super(postId, createdOn, title, definition, creator, creatorName, status, type);
      this.postDetails = postDetails;
   }

   public {name}_PostDTO() {}

   @Override
   public List<{name}_PostDetailDTO> getPostDetails() {
      return postDetails;
   }

   @Override
   public void setPostDetails(List<{name}_PostDetailDTO> postDetails) {
      this.postDetails = postDetails;
   }
}

CLASS: {name}_PostDetailDTO

public class {name}_PostDetailDTO extends PostDetailDTO {
        // OPTIONAL: specific Data like pollAnswer or text, getter and setter needed

   public {name}_PostDetailDTO(Long postDetailsId, Date createdOn, Long creator, String creatorName, Long postId /* OPTIONAL: specific Data */) {
      super(postDetailsId, createdOn, creator, creatorName, postId);
        /* OPTIONAL: specific Data */
   }
}

```

### Repo

NOTE: check already implemented methods for reference, <br> use //<editor-fold desc="**{name}**">...//</editor-fold> for clean code in IDEA

#### In the PostRepository
1. Implement method create ***{name}*** Post(***{name}***_PostDTO postDTO), build the ***{name}***_Post with all specific
   data and persist it
2. Implement a new case ***{name}*** in the switch of the getPost method, that builds a ***{name}***_PostDTO with all the
   specific data

```java
METHOD: CREATE

//<editor-fold desc="{name}">
    public void create{name}Post({name}_PostDTO postDTO) {
        try {
            BoastUser user = entityManager.find(BoastUser.class, postDTO.getCreatorId());
            if (user == null) throw new IllegalArgumentException();

            {name}_Post post = new {name}_Post(postDTO, user);
            // OPTIONAL: if a extra class for the type specific data is used build the objects here (check createPollPost for reference)
            entityManager.persist(post);
        } catch (Exception e) {
            throw new IllegalArgumentException();
        }

    }
//</editor-fold>

CASE IN THE GETPOST METHOD
        
case {name} -> {
    /* OPTIONAL: specific Data - typeInfoDTO */
    List<{name}_PostDetailDTO> postDetailDTOS = new LinkedList<>();
    for ({name}_PostDetail postDetail : (({name}_Post) post).getPostDetails()) {
        postDetailDTOS.add(new {name}_PostDetailDTO(
            postDetail.getPostDetailsId(),
            postDetail.getCreatedOn(),
            postDetail.getCreator().getUserId(),
            postDetail.getCreator().getUsername(),
            post.getPostId(),
            /* OPTIONAL: specific Data */));
    }
    return new {name}_PostDTO(post.getPostId(),
        post.getCreatedOn(),
        post.getTitle(),
        post.getDefinition(),
        post.getCreator().getUserId(),
        post.getCreator().getUsername(),
        post.getStatus().name(),
        PostType.{name}.name(),
        /* OPTIONAL: specific Data - typeInfo */
        postDetailDTOS);
}
```

#### In the PostDetailRepository
1. Implement method add ***{name}*** PostDetails(***{name}***_PostDetailDTO postDetailDTO), build the ***{name}***_
   PostDetail with all specific data and persist it

```java
//<editor-fold desc="{name}">
    public void add{name}PostDetails({name}_PostDetailDTO postDetailDTO) {
        try {
            BoastUser user = entityManager.find(BoastUser.class, postDetailDTO.getCreatorId());
            {name}_Post post = entityManager.find({name}_Post.class, postDetailDTO.getPostId());
            // OPTIONAL: if a extra class for the type specific data is used find it here and check that its not empty (check addPollPostDetails for reference)
            if (user == null || post == null) throw new IllegalArgumentException();

            {name}_PostDetail postDetail = new {name}_PostDetail(postDetailDTO, user, post /* OPTIONAL: specific Data */);

            post.addPostDetail(postDetail);

            entityManager.persist(postDetail);
        } catch (Exception e) {
            throw new IllegalArgumentException();
        }
    }
    //</editor-fold>
```

### Resource

NOTE: surround all method logic with try catch and return Response (200 if ok, 422 if data was invalid), <br> use //<editor-fold desc="**{name}**">...//</editor-fold> for clean code in IDEA

#### In the PostResource
1. Implement resource with HTTPMethod POST posts/***{name}*** with body ***{name}***_PostDTO and call repo method

```java
//<editor-fold desc="{name}">
    @POST
    @Path("/{name}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createTextPost({name}_PostDTO postDTO) {
        try {
            postRepository.create{name}Post(postDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }
//</editor-fold>
```

#### In the PostDetailResource
1. Implement resource with HTTPMethod POST post-details/***{name}*** with body ***{name}***_PostDetailDTO and call repo method


```java
//<editor-fold desc="{name}">
    @POST
    @Path("/{name}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response addTextPostDetail({name}_PostDetailDTO postDetailDTO) {
        try {
            postDetailRepository.add{name}PostDetails(postDetailDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }
    //</editor-fold>
```