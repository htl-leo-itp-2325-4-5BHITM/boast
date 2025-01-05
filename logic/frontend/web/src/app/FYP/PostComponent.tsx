"use client"
import {PostModel} from "@/model/model";
import {Box, Button, IconButton, TextField, Typography} from "@mui/material";
import CloseIcon from "@mui/icons-material/Close";
import Grid from "@mui/material/Grid2";
import {useEffect, useState} from "react";
import axios from "axios";
import {useUser} from "@/provider/UserProvider";

export default function PostComponent({ postData, onGoBack }: { postData: PostModel, onGoBack: () => void }) {
    const [post, setPost] = useState<PostModel>(postData);
    const [selectedOption, setSelectedOption] = useState<number | null>(null);
    const [answer, setAnswer] = useState<string>("");
    const { user } = useUser();

    const placeBet = async () => {
        const requestBody = {
            postDetailsId: 0,
            createdOn: new Date().toISOString(),
            creatorId: user?.userId || 0,
            creatorName: user?.username || "string",
            postId: post.postId,
            text: answer
        };

        try {
            const response = await axios.post("https://www.boast.social/api/post-details/text", requestBody);
            console.log(response.data);
            setAnswer("");
            await reloadPost();
        } catch (error) {
            console.error("Error submitting text answer:", error);
        }
    }

    const reloadPost = async () => {
        try {
            const r = await axios.get(`https://www.boast.social/api/posts/${postData.postId}`);
            setPost(r.data);
        } catch (error) {
            console.error("Error reloading post:", error);
        }
    }

    useEffect(() => {
        setPost(postData);
    }, [postData]);

    const handlePollOptionClick = async (poll_answerId: number) => {
        const requestBody = {
            postDetailsId: 0,
            createdOn: new Date().toISOString(),
            creatorId: user?.userId || 0,
            creatorName: user?.username || "string",
            postId: post.postId,
            poll_answerId: poll_answerId
        };

        try {
            const response = await axios.post("https://www.boast.social/api/post-details/poll", requestBody);
            console.log(response.data);
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

            <Grid container spacing={5}>
                <Grid size={7} sx={{display: "flex", flexDirection: "column", justifyContent: "space-between", height: "65vh"}}>
                    <Box>
                        <Typography variant="h4" fontWeight="bold">{post?.title}</Typography>
                        <Typography variant="h6" sx={{ maxWidth: '100%', wordWrap: 'break-word' }}>
                            {post?.definition}
                        </Typography>
                        <Typography variant="body1" color="#4ECA31">
                            {post?.postDetails?.length || 0} participants
                        </Typography>
                        <Typography variant="body1" color="#D3D3D3" sx={{ maxWidth: '100%' }} textAlign="right">
                            by {post?.creatorName}
                        </Typography>
                        {post.type === "POLL" && (
                            <Box>
                                <Typography variant="h5" fontWeight="bold">Poll Options:</Typography>
                                <Box>
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
                                                    background: selectedOption !== null
                                                        ? `linear-gradient(to right, #2A4BFF ${calculateVotePercentage(answer.poll_answerId)}%, grey ${calculateVotePercentage(answer.poll_answerId)}%)`
                                                        : "grey",
                                                },
                                                borderRadius: "30px",
                                                my: 1
                                            }}
                                        >
                                            <Typography
                                                fontWeight="bold"
                                                textAlign="center"
                                                width="100%"
                                            >
                                                {answer.title} {selectedOption !== null && `(${calculateVotePercentage(answer.poll_answerId)}%)`}
                                            </Typography>
                                        </Button>
                                    ))}
                                </Box>
                            </Box>
                        )}
                    </Box>
                    <Box>
                        {post.type === "TEXT" && (
                            <Box>
                                <Typography variant="h5" fontWeight="bold">Place your bet: </Typography>
                                <Box sx={{display: "flex"}}>
                                    <TextField
                                        label=""
                                        placeholder=""
                                        variant="outlined"
                                        fullWidth
                                        value={answer}
                                        onChange={(e) => setAnswer(e.target.value)}
                                        sx={{
                                            '& .MuiInputBase-input': {
                                                color: 'white',
                                            },
                                            '& .MuiInputLabel-root': {
                                                color: 'white',
                                            },
                                        }}
                                    />
                                    <Button sx={{ py: 1.5, bgcolor: "#3656FF", mx: 1, width: "20%" }} variant="contained" fullWidth disabled={answer === ""} onClick={placeBet}>
                                        <Typography fontWeight="bold">
                                            Bet
                                        </Typography>
                                    </Button>
                                </Box>
                            </Box>
                        )}

                    </Box>
                </Grid>
                <Grid size={5}>
                    <Typography variant="h5" fontWeight="bold" py={1}>{post.type === "POLL" ? "" : "Placed Bets"}</Typography>
                    <Box sx={{maxHeight: "60vh", overflowY: "scroll"}}>
                        {post.type === "TEXT" && (
                            <Box>
                                {post?.postDetails?.map((bet, index) => (
                                    <Box key={index} sx={{borderBottom: "1px solid #4ECA31", padding: 1}}>
                                        <Typography variant="body1">{bet.creatorName}:</Typography>
                                        <Typography variant="body2">{bet.text}</Typography>
                                    </Box>
                                ))}
                            </Box>
                        )}
                    </Box>
                </Grid>
            </Grid>
        </Box>
    );
}