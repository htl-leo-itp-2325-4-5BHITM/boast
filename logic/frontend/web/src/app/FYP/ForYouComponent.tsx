"use client";
import { Box, Button, Dialog, DialogContent, DialogTitle, TextField, Typography } from "@mui/material";
import Grid from "@mui/material/Grid2";
import React, { useEffect, useState } from "react";
import axios from "axios";
import { getPost, getPosts } from "@/service/post";
import { PostModel } from "@/model/model";
import { useUser } from "@/provider/UserProvider";

const colors = ["#C20B4E", "#3656FF", "#4ECA31"];

function getRandomColor() {
    return colors[Math.floor(Math.random() * colors.length)];
}

interface ForYouComponentProps {
    setShowPostComponent: (show: boolean) => void;
    setSelectedPost: (post: PostModel | null) => void;
}

export default function ForYouComponent({ setShowPostComponent, setSelectedPost }: ForYouComponentProps) {
    const [posts, setPosts] = useState<PostModel[]>([]);
    const [dialogOpen, setDialogOpen] = useState(false);
    const [textInput, setTextInput] = useState("");
    const [selectedPollAnswer, setSelectedPollAnswer] = useState("1");
    const [currentPost, setCurrentPost] = useState<PostModel | null>(null);
    const { user } = useUser();


    const handleGridItemClick = (post: PostModel) => {
        setCurrentPost(post);
        setDialogOpen(true);
    };

    const handleClose = () => {
        setDialogOpen(false);
        setCurrentPost(null);
        setTextInput("");
        setSelectedPollAnswer("1");
    };

    const handleBet = async () => {
        if (currentPost?.type === "TEXT") {
            const requestBody = {
                createdOn: new Date().toISOString(),
                creatorId: user?.userId,
                creatorName: user?.username,
                postId: currentPost.postId,
                text: textInput
            };

            try {
                await axios.post("https://www.boast.social/api/post-details/text", requestBody);
                handleClose();
            } catch (error) {
                console.error("Error sending bet:", error);
            }
        } else if (currentPost?.type === "POLL") {
            const requestBody = {
                creatorId: user?.userId,
                creatorName: user?.username,
                postId: currentPost.postId,
                pollAnswerId: selectedPollAnswer
            };

            try {
                await axios.post("https://www.boast.social/api/post-details/poll", requestBody);
                handleClose();
            } catch (error) {
                console.error("Error sending bet:", error);
            }
        }
    };

    const handleShowMore = () => {
        setSelectedPost(currentPost);
        setShowPostComponent(true);
        handleClose();
    };

    useEffect(() => {
        async function fetchPosts() {
            try {
                const postIds = await getPosts();
                const postDetails = await Promise.all(postIds.map(id => getPost(id)));
                setPosts(postDetails);
            } catch (error) {
                console.error('Error fetching posts:', error);
            }
        }

        fetchPosts();
    }, []);

    return (
        <>
            <Typography
                variant="h6"
                color="white"
                sx={{
                    padding: "20px",
                    position: "sticky",
                    top: 0,
                    zIndex: 1,
                }}
            >
                For you
            </Typography>
            <Grid container spacing={4}
                  sx={{
                      width: "100%",
                      margin: "auto",
                  }}
            >
                {posts.map(post => (
                    <Grid size={4} key={post.postId}
                          sx={{
                              display: "flex",
                              justifyContent: "center",
                          }}
                    >
                        <Box
                            bgcolor={getRandomColor()}
                            height="12rem"
                            width="12rem"
                            display="flex"
                            justifyContent="center"
                            alignItems="center"
                            borderRadius="13px"
                            padding="10px"
                            sx={{
                                cursor: "pointer"
                            }}
                            onClick={() => handleGridItemClick(post)}
                        >
                            <Typography color="#ffffff" fontWeight={700}>
                                {post.title}
                            </Typography>
                        </Box>
                    </Grid>
                ))}
            </Grid>
            <Dialog open={dialogOpen} onClose={handleClose} maxWidth={"sm"} fullWidth={true}>
                <DialogTitle sx={{ bgcolor: "#22264B", color: "white" }}>
                    {currentPost?.title}
                    <Button variant="outlined" sx={{marginLeft: "auto", float: "right"}} color="primary" onClick={handleShowMore}>
                        Show More
                    </Button>
                </DialogTitle>
                <DialogContent sx={{ bgcolor: "#22264B", color: "white" }}>
                    <Typography>{currentPost?.definition}</Typography>
                    <Typography align="right">by {currentPost?.creatorName}</Typography>
                    <Typography align="right">{currentPost?.postDetails?.length} participants</Typography>
                    <Box>
                        {currentPost?.type === "TEXT" && (
                            <TextField
                                label="Your Response"
                                variant="outlined"
                                fullWidth
                                margin="normal"
                                value={textInput}
                                onChange={(e) => setTextInput(e.target.value)}
                                InputProps={{ style: { color: 'white' } }}
                                InputLabelProps={{ style: { color: 'white' } }}
                            />
                        )}
                        {currentPost?.type === "POLL" && Array.isArray(currentPost.typeInfo.pollAnswers) && (
                            <TextField
                                select
                                label="Select an Option"
                                variant="outlined"
                                fullWidth
                                margin="normal"
                                value={selectedPollAnswer}
                                onChange={(e) => setSelectedPollAnswer(e.target.value)}
                                SelectProps={{ native: true }}
                                InputProps={{ style: { color: 'white' } }}
                                InputLabelProps={{ style: { color: 'white' } }}
                            >
                                {currentPost.typeInfo.pollAnswers.map((option) => (
                                    <option key={option.poll_answerId} value={option.poll_answerId}>
                                        {option.title}
                                    </option>
                                ))}
                            </TextField>
                        )}
                        <Box display="flex" justifyContent="space-between" mt={2}>
                            <Button variant="contained" color="secondary" onClick={handleClose}>
                                Close
                            </Button>
                            <Button variant="contained" color="primary" onClick={handleBet}>
                                Bet
                            </Button>
                        </Box>
                    </Box>
                </DialogContent>
            </Dialog>
        </>
    );
}