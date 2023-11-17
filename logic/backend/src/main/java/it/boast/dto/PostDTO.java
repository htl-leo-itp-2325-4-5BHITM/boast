package it.boast.dto;

import java.util.List;

public record PostDTO(String title, String definition, String creator, String winner, List<PostDetailDTO> postDetails) {

}
