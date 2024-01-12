package social.boast;

import io.quarkus.test.common.http.TestHTTPEndpoint;
import io.quarkus.test.junit.QuarkusTest;
import social.boast.resource.PostResource;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
@TestHTTPEndpoint(PostResource.class)
public class PostTest {

    @BeforeEach
    void setUp() {

    }

    @Test
    void ping() {
        given()
                .when().get("/ping")
                .then()
                .statusCode(200)
                .body(is("pong"));
    }
}
