package it.boast;

import io.quarkus.test.common.http.TestHTTPEndpoint;
import io.quarkus.test.junit.QuarkusTest;
import it.boast.resource.PostResource;
import jakarta.inject.Inject;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
@TestHTTPEndpoint(PostResource.class)
public class PostTest {

    @Test
    void ping() {
        given()
                .when().get("/ping")
                .then()
                .statusCode(200)
                .body(is("pong"));
    }

    @Test
    void addPost() {
        JsonObject post = Json.createObjectBuilder()
                .add("title", "Test Post")
                .add("definition", "this is a test post")
                .add("creator", "Me")
                .add("winner", "Me")
                .add("postDetails", Json.createArrayBuilder()
                        .add(Json.createObjectBuilder()
                                .add("bet", "yes")
                                .add("creator", "you"))
                        .add(Json.createObjectBuilder()
                                .add("bet", "no")
                                .add("creator", "they"))
                )
                .build();

        given()
                .contentType("application/json")
                .when()
                .body(post.toString())
                .post("addPost")
                .then()
                .statusCode(204);


        JsonObject post2 = Json.createObjectBuilder()
                .add("title", "Test Post2")
                .add("definition", "this is a test post")
                .add("creator", "Me")
                .add("winner", "Me")
                .add("postDetails", Json.createArrayBuilder()
                        .add(Json.createObjectBuilder()
                                .add("bet", "yes2")
                                .add("creator", "you"))
                        .add(Json.createObjectBuilder()
                                .add("bet", "no2")
                                .add("creator", "they"))
                        .add(Json.createObjectBuilder()
                                .add("bet", "yes3")
                                .add("creator", "you"))
                )
                .build();

        given()
                .contentType("application/json")
                .when()
                .body(post2.toString())
                .post("addPost")
                .then()
                .statusCode(204);

    }

    @Test
    void getPostsAsList() {
        given()
                .when().get("/getPostsAsList")
                .then()
                .statusCode(200)
                .body(is("[]"));

        JsonObject post = Json.createObjectBuilder()
                .add("title", "Test Post")
                .add("definition", "this is a test post")
                .add("creator", "Me")
                .add("winner", "Me")
                .add("postDetails", Json.createArrayBuilder()
                        .add(Json.createObjectBuilder()
                                .add("bet", "yes")
                                .add("creator", "you"))
                        .add(Json.createObjectBuilder()
                                .add("bet", "no")
                                .add("creator", "they")).toString()
                )
                .build();

        given()
                .contentType("application/json")
                .when()
                .body(post.toString())
                .post("addPost")
                .then()
                .statusCode(204);

        JsonArray array = Json.createArrayBuilder().add(post).build();

        given()
                .when().get("/getPostsAsList")
                .then()
                .statusCode(200)
                .body(is(array.toString()));
    }
}
