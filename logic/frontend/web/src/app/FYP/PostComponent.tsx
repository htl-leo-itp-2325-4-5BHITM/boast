"use client"
import { PostModel } from "@/model/model";
import { Box, List, ListItem, ListItemText, Typography, Button, Dialog, DialogTitle, DialogContent, DialogActions } from "@mui/material";
import { useState } from "react";
import axios from "axios";
import { useUser } from "@/provider/UserProvider";

export default function PostComponent({ post, onGoBack }: { post: PostModel, onGoBack: () => void }) {
    const { user } = useUser();
    const [dialogOpen, setDialogOpen] = useState(false);
    const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);

    const handleSelectAnswer = (answerId: number) => {
        setSelectedAnswer(answerId);
        setDialogOpen(true);
    };

    const handleConfirmSelection = async () => {
        if (selectedAnswer !== null) {
            try {
                const url = post.type === "POLL"
                    ? `https://www.boast.social/api/posts/${post.postId}/poll/winners/${selectedAnswer}`
                    : `https://www.boast.social/api/posts/${post.postId}/text/winners`;

                const requestBody = post.type === "POLL"
                    ? {}
                    : { first: [selectedAnswer], second: [], third: [] };

                await axios.post(url, requestBody, {
                    headers: {
                        'accept': '*/*',
                        'Content-Type': 'application/json'
                    }
                });
                setDialogOpen(false);
            } catch (error) {
                console.error("Error selecting best answer:", error);
            }
        }
    };

    return (
        <Box p={3} bgcolor="#1A1C40" color="white" borderRadius="8px">
            <Button variant="contained" color="primary" onClick={onGoBack} sx={{ mb: 2, position: "relative", top: 0 }}>
                Go Back
            </Button>
            <Typography variant="h4" mb={2}>{post.title}</Typography>
            <Typography variant="body1" mb={2}>{post.definition}</Typography>
            <Typography variant="subtitle1" mb={2}>by {post.creatorName}</Typography>
            <Typography variant="subtitle2" mb={2}>{post.postDetails?.length} participants</Typography>
            <List>
                {post.type === "POLL" && post.typeInfo.pollAnswers.map((answer) => (
                    <ListItem key={answer.poll_answerId} sx={{ bgcolor: "#22264B", mb: 1, borderRadius: "8px" }}>
                        <ListItemText
                            primary={answer.title}
                            primaryTypographyProps={{ color: "white", fontWeight: "bold" }}
                        />
                        {post.creatorName === user?.username && (
                            <Button variant="contained" color="secondary" onClick={() => handleSelectAnswer(answer.poll_answerId)}>
                                Select as Best Answer
                            </Button>
                        )}
                    </ListItem>
                ))}
                {post.postDetails?.map((detail) => (
                    <ListItem key={detail.postDetailsId} sx={{ bgcolor: "#22264B", mb: 1, borderRadius: "8px" }}>
                        <ListItemText
                            primary={detail.creatorName}
                            secondary={detail.text || post?.typeInfo.pollAnswers.find((answer) => answer?.poll_answerId === detail.poll_answerId)?.title}
                            primaryTypographyProps={{ color: "white", fontWeight: "bold" }}
                            secondaryTypographyProps={{ color: "white" }}
                        />
                        {post.creatorName === user?.username && (
                            <Button variant="contained" color="secondary" onClick={() => handleSelectAnswer(detail.creatorId)}>
                                Select as Best Answer
                            </Button>
                        )}
                    </ListItem>
                ))}
            </List>
            <Dialog open={dialogOpen} onClose={() => setDialogOpen(false)}>
                <DialogTitle>Confirm Selection</DialogTitle>
                <DialogContent>
                    <Typography>Are you sure you want to select this answer as the best answer?</Typography>
                </DialogContent>
                <DialogActions>
                    <Button onClick={() => setDialogOpen(false)} color="primary">
                        Cancel
                    </Button>
                    <Button onClick={handleConfirmSelection} color="primary">
                        Confirm
                    </Button>
                </DialogActions>
            </Dialog>
        </Box>
    );
}