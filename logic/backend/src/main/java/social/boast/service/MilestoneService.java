package social.boast.service;

import jakarta.enterprise.context.ApplicationScoped;
import social.boast.dto.milestone.MilestoneDTO;
import social.boast.model.post.Post;
import social.boast.model.post.RankingPost;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.poll.Poll_PostDetail;
import social.boast.model.user.BoastUser;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@ApplicationScoped
public class MilestoneService {

    public List<MilestoneDTO> getMilestones(Long reqUserId) {
        BoastUser user = BoastUser.findById(reqUserId);
        List<MilestoneDTO> milestones = new LinkedList<>();

        milestones.add(new MilestoneDTO("Win", "Be the Winner of a boast!", true));
        milestones.add(new MilestoneDTO("Daily Boast", "Create a boast everyday for 3 days in a row.", false));

        return milestones;
    }

    public boolean checkDailyBoast(BoastUser user) {
        List<Date> postDates = user.posts.stream()
                .map(p -> p.createdOn)
                .sorted()
                .collect(Collectors.toList());

        if (postDates.size() < 3) {
            return false;
        }

        for (int i = 0; i <= postDates.size() - 3; i++) {
            Date first = postDates.get(i);
            Date second = postDates.get(i + 1);
            Date third = postDates.get(i + 2);

            long diff1 = second.getTime() - first.getTime();
            long diff2 = third.getTime() - second.getTime();

            if (TimeUnit.DAYS.convert(diff1, TimeUnit.MILLISECONDS) <= 1 &&
                    TimeUnit.DAYS.convert(diff2, TimeUnit.MILLISECONDS) <= 1) {
                return true;
            }
        }

        return false;
    }

    private boolean checkWin(BoastUser user) {
        boolean win = false;
        List<Post> posts = Post.listAll();
        for (Post post : posts) {
            if (post instanceof RankingPost) {
                for (Long winnerUserId : ((RankingPost) post).getWinnerRankingDTO().first()) {
                    if (winnerUserId.equals(user.userId)) {
                        win = true;
                        break;
                    }
                    break;
                }
            } else if (post instanceof Poll_Post) {
                if (((Poll_Post) post).winnerPoll != null) {
                    for (Poll_PostDetail postDetail : ((Poll_Post) post).postDetails) {
                        if (postDetail.creator.userId.equals(user.userId) && postDetail.pollAnswer.poll_answerId.equals(((Poll_Post) post).winnerPoll.poll_answerId)) {
                            win = true;
                        }
                    }
                    break;
                }
            }
        }

        return win;
    }

}
