package social.boast.service;

import com.auth0.jwk.Jwk;
import com.auth0.jwk.JwkProvider;
import com.auth0.jwk.UrlJwkProvider;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.security.UnauthorizedException;
import jakarta.enterprise.context.ApplicationScoped;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.interfaces.RSAPublicKey;
import java.util.*;

@ApplicationScoped
public class AuthService {

    private static final String AUTH0_API_URL = "https://dev-hqdjfde22jocup8g.us.auth0.com";
    private static final String AUTH0_API_AUDIENCE = "https://dev-hqdjfde22jocup8g.us.auth0.com/api/v2/";
    private static final String AUTH0_CLIENT_ID = "IteLOrN17vUpWI4LHgkJJh6L9kg8rIzY";
    private static final String AUTH0_CLIENT_SECRET = "sh_rFlyPffYvTAnTpItspeHU60V8p7KFegBWEeOFwl8wW362Bw9l8V_n9b3XiCL2";
    private static final String AUTH0_ISSUER = "https://dev-hqdjfde22jocup8g.us.auth0.com";
    private static final String API_SECRET = "8KE7tW91xs5hyKKU47F8oihxL572yBN7QNfWh4n82laPyevgOIjdMAM6LOawuwDfUFwGyMGCelpk0NXWo4gBQnZSViMrifz7uUZa";
    private static final String API_ISSUER = "boast.social";

    private static HttpClient client = HttpClient.newHttpClient();
    private static ObjectMapper objectMapper = new ObjectMapper();


    public DecodedJWT decodeJWT(String token) {
        JwkProvider provider = new UrlJwkProvider(AUTH0_ISSUER);
        try {
            DecodedJWT jwt = JWT.decode(token);
            Jwk jwk = provider.get(jwt.getKeyId());
            Algorithm algorithm = Algorithm.RSA256((RSAPublicKey) jwk.getPublicKey(), null);
            JWTVerifier verifier = JWT.require(algorithm)
                    .withIssuer("https://dev-hqdjfde22jocup8g.us.auth0.com/")
                    .build();
            return verifier.verify(token);
        } catch (Exception e) {
            throw new UnauthorizedException("Invalid JWT token");
        }
    }

    public String getSignedToken(Map<String, String> claims, Date expires)
            throws IllegalArgumentException, JWTCreationException {
        if (claims == null) {
            throw new IllegalArgumentException("Claims cannot be null!");
        } else if (expires == null) {
            throw new IllegalArgumentException("Expiration date cannot be null!");
        }
        JWTCreator.Builder create = JWT.create();
        Set<Map.Entry<String, String>> entrySet = claims.entrySet();
        for (Iterator<Map.Entry<String, String>> iterator = entrySet.iterator(); iterator.hasNext(); ) {
            Map.Entry<String, String> entry = iterator.next();
            create.withClaim(entry.getKey(), entry.getValue());
        }
        create.withIssuedAt(new Date());
        create.withIssuer(API_ISSUER);
        create.withExpiresAt(expires);
        return create.sign(Algorithm.HMAC256(API_SECRET));
    }

    public Map<String, String> verifyTokenAndReturnClaims(String token) throws IllegalArgumentException {
        JWTVerifier verifier = JWT.require(Algorithm.HMAC256(API_SECRET)).withIssuer(API_ISSUER).build();
        DecodedJWT decodedToken = verifier.verify(token);
        Map<String, Claim> claims = decodedToken.getClaims();
        Set<Map.Entry<String, Claim>> entrySet = claims.entrySet();
        Map<String, String> claimsAsStringMap = new HashMap<>();
        for (Iterator<Map.Entry<String, Claim>> iterator = entrySet.iterator(); iterator.hasNext(); ) {
            Map.Entry<String, Claim> entry = iterator.next();
            claimsAsStringMap.put(entry.getKey(), entry.getValue().asString());
        }
        return claimsAsStringMap;
    }

    private String getAuth0APIAccessToken() throws URISyntaxException, IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI(AUTH0_API_URL + "/oauth/token"))
                .header("content-type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(
                        "{\n" +
                                "  \"grant_type\": \"client_credentials\",\n" +
                                "  \"client_id\": \"" + AUTH0_CLIENT_ID + "\",\n" +
                                "  \"client_secret\": \"" + AUTH0_CLIENT_SECRET + "\",\n" +
                                "  \"audience\": \"" + AUTH0_API_AUDIENCE + "\"\n" +
                                "}"))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() == 200) {
            return objectMapper.readTree(response.body()).get("access_token").asText();
        } else {
            System.out.println("Failed to get Token: " + response.statusCode() + " - " + response.body());
            throw new IllegalArgumentException("Failed to create managing user");
        }
    }

    public void deleteUser(String id) throws URISyntaxException, IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI(AUTH0_API_URL + "/api/v2/users/" + URLEncoder.encode(id, StandardCharsets.UTF_8.toString())))
                .header("Authorization", "Bearer " + getAuth0APIAccessToken())
                .DELETE()
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 204) {
            System.out.println("DELETE AUTH0 USER ERROR: " + response.statusCode() + " - " + response.body());
            throw new IllegalArgumentException("Failed to delete user: " + response.body());
        }
    }

    public void updateUser(String sub, String email, String name) throws URISyntaxException, IOException, InterruptedException {
        String requestBody = "{\"email\":\"" + email + "\",\"name\":\"" + name + "\"}";

        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI(AUTH0_API_URL + "/api/v2/users/" + URLEncoder.encode(sub, StandardCharsets.UTF_8.toString())))
                .header("Authorization", "Bearer " + getAuth0APIAccessToken())
                .header("Content-Type", "application/json")
                .method("PATCH", HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            System.out.println("UPDATE AUTH0 USER ERROR: " + response.statusCode() + " - " + response.body());
            throw new IllegalArgumentException("Failed to delete user: " + response.body());
        }
    }

}

