"use client"
import {PostModel} from "@/model/model";
import {Box, Button, IconButton, TextField, Typography} from "@mui/material";
import CloseIcon from "@mui/icons-material/Close";
import {checkAuth, getData, postData} from "@/service/ApiService";
import Grid from "@mui/material/Grid";
import { useEffect, useState } from "react";

export default function PostComponent({ data, onGoBack }: { data: PostModel, onGoBack: () => void }) {
    const [post, setPost] = useState<PostModel>(data);
    const [selectedOption, setSelectedOption] = useState<number | null>(null);
    const [answer, setAnswer] = useState<string>("");

    const placeBet = async () => {
        let authUser = checkAuth();
        const requestBody = {
            postDetailsId: 0,
            createdOn: new Date().toISOString(),
            creatorId: authUser?.userId || 0,
            creatorName: authUser?.username || "string",
            postId: post.postId,
            text: answer
        };

        try {
            const response = await postData<any>("/post-details/text", requestBody);
            console.log(response);
            setAnswer("");
            await reloadPost();
        } catch (error) {
            console.error("Error submitting text answer:", error);
        }
    }

    const reloadPost = async () => {
        try {
            const r = await getData<PostModel>(`/posts/${data.postId}`);
            setPost(r);
        } catch (error) {
            console.error("Error reloading post:", error);
        }
    }

    useEffect(() => {
        setPost(data);
    }, [data]);

    const handlePollOptionClick = async (poll_answerId: number) => {
        let authUser = checkAuth();
        const requestBody = {
            postDetailsId: 0,
            createdOn: new Date().toISOString(),
            creatorId: authUser?.userId || 0,
            creatorName: authUser?.username || "string",
            postId: post.postId,
            poll_answerId: poll_answerId
        };

        try {
            const response= await postData<any>("/post-details/poll", requestBody);
            console.log(response);
            setSelectedOption(poll_answerId);
            await reloadPost();
        } catch (error) {
            console.error("Error submitting poll answer:", error);
        }
    }

    const calculateVotePercentage = (poll_answerId: number) => {
        const totalVotes = post.postDetails.length;
        const answerVotes = post.postDetails.filter(detail => detail.poll_answerId === poll_answerId).length;
        return totalVotes > 0 ? (answerVotes / totalVotes * 100).toFixed(2) : "0.00";
    }

    return (
        <Box p={3} bgcolor="#22264B" color="white" borderRadius="8px" position="relative" sx={{p: 8, overflow: "hidden"}}>
            <IconButton
                onClick={onGoBack}
                sx={{
                    position: "absolute",
                    top: 8,
                    right: 8,
                    bgcolor: "#F1025E",
                    color: "white",
                    "&:hover": {
                        bgcolor: "#D0025E",
                    }
                }}
            >
                <CloseIcon />
            </IconButton>

            <Grid container spacing={2}>
                {/* Main Content */}
                <Grid item xs={12} md={7} sx={{ display: "flex", flexDirection: "column", gap: 2 }}>
                    <Box>
                        <Typography variant="h5" fontWeight="bold">{post?.title}</Typography>
                        <Typography variant="body1" sx={{ wordWrap: 'break-word', mb: 1 }}>
                            {post?.definition}
                        </Typography>
                        <Typography variant="body2" color="#4ECA31">
                            {post?.postDetails?.length || 0} participants
                        </Typography>
                        <Typography variant="body2" color="#D3D3D3" textAlign="right">
                            by {post?.creatorName}
                        </Typography>
                    </Box>

                    {/* Poll Section */}
                    {post.type === "POLL" && (
                        <Box>
                            <Typography variant="h6" fontWeight="bold">Poll Options:</Typography>
                            {post?.typeInfo?.pollAnswers?.map((answer) => (
                                <Button
                                    key={answer.poll_answerId}
                                    variant="contained"
                                    fullWidth
                                    onClick={() => handlePollOptionClick(answer.poll_answerId)}
                                    sx={{
                                        background: selectedOption !== null
                                            ? `linear-gradient(to right, #3656FF ${calculateVotePercentage(answer.poll_answerId)}%, grey ${calculateVotePercentage(answer.poll_answerId)}%)`
                                            : "grey",
                                        color: "white",
                                        "&:hover": {
                                            background: "grey",
                                        },
                                        borderRadius: "30px",
                                        my: 1
                                    }}
                                >
                                    <Typography fontWeight="bold" textAlign="center">
                                        {answer.title} {selectedOption !== null && `(${calculateVotePercentage(answer.poll_answerId)}%)`}
                                    </Typography>
                                </Button>
                            ))}
                        </Box>
                    )}

                    {/* Text Input Section */}
                    {post.type === "TEXT" && (
                        <Box>
                            <Typography variant="h6" fontWeight="bold">Place your bet:</Typography>
                            <Box sx={{ display: "flex", gap: 1, mt: 1 }}>
                                <TextField
                                    label="Your Answer"
                                    variant="outlined"
                                    fullWidth
                                    value={answer}
                                    onChange={(e) => setAnswer(e.target.value)}
                                    InputProps={{
                                        style: { color: 'white' }
                                    }}
                                />
                                <Button
                                    sx={{ bgcolor: "#3656FF", px: 2 }}
                                    variant="contained"
                                    disabled={answer === ""}
                                    onClick={placeBet}
                                >
                                    Bet
                                </Button>
                            </Box>
                        </Box>
                    )}
                </Grid>

                {/* Sidebar */}
                <Grid item xs={12} md={5}>
                    <Typography variant="h6" fontWeight="bold" mb={1}>{post.type === "POLL" ? "" : "Placed Bets"}</Typography>
                    <Box sx={{ maxHeight: "50vh", overflowY: "auto", border: "1px solid #4ECA31", borderRadius: 2, p: 1 }}>
                        {post.type === "TEXT" && post?.postDetails?.map((bet, index) => (
                            <Box key={index} sx={{ borderBottom: "1px solid #4ECA31", p: 1 }}>
                                <Typography variant="body2"><strong>{bet.creatorName}:</strong> {bet.text}</Typography>
                            </Box>
                        ))}
                    </Box>
                </Grid>
            </Grid>
        </Box>
    );
}