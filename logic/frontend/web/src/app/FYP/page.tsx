"use client";

import Grid from "@mui/material/Grid2";
import {Avatar, Box, Dialog, DialogContent, DialogTitle, List, ListItem, ListItemAvatar, ListItemText, TextField, Typography} from "@mui/material";
import {useEffect, useState} from "react";
import {PostModel} from "@/model/model";
import {getPost, getPosts} from "@/service/post";

const colors = ["#C20B4E", "#3656FF", "#4ECA31"];

function getRandomColor() {
    return colors[Math.floor(Math.random() * colors.length)];
}

export default function Page() {
    const [posts, setPosts] = useState<PostModel[]>([]);
    const [selectedPost, setSelectedPost] = useState<PostModel | null>(null);
    const [dialogOpen, setDialogOpen] = useState(false);

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

    const handleGridItemClick = (post: PostModel) => {
        setSelectedPost(post);
        setDialogOpen(true);
    };

    const handleClose = () => {
        setDialogOpen(false);
        setSelectedPost(null);
    };

    return (
        <Grid container spacing={2} p="40px" bgcolor="#1A1C40" height="100%" width="100%">
            <Grid size={8} bgcolor="#22264B" padding="20px" height="200vh">
                <Typography variant="h6" color="white">For you</Typography>
                <Grid container spacing={12} display="flex" justifyContent="center" alignItems="center">
                    {posts.map(post => (
                        <Grid key={post.postId} size={4} display="flex" justifyContent="center" alignItems="center" padding="10px" onClick={() => handleGridItemClick(post)}>
                            <Box bgcolor={getRandomColor()} m="5px" height="10rem" width="10rem" display="flex" justifyContent="center" alignItems="center" borderRadius="13px">
                                <Typography color="#ffffff" fontWeight={700}>
                                    {post.title}
                                </Typography>
                            </Box>
                        </Grid>
                    ))}
                </Grid>
            </Grid>
            <Grid size={4}>
                <Box bgcolor="#22264B" p="10px">
                    <form>
                        <Typography
                            variant={"h6"}
                            color={"white"}
                        >
                            Create
                        </Typography>
                        <TextField
                            label="Bet"
                            variant="outlined"
                            fullWidth
                            margin="normal"
                            InputProps={{style: {color: 'white'}}}
                            InputLabelProps={{style: {color: 'white'}}}
                        />
                        <TextField
                            label="Description"
                            variant="outlined"
                            fullWidth
                            margin="normal"
                            InputProps={{style: {color: 'white'}}}
                            InputLabelProps={{style: {color: 'white'}}}
                        />
                    </form>
                </Box>
                <Box bgcolor="#22264B" p="10px" color="#fff">
                    <Typography variant="h6" color="white">For you</Typography>
                    <List>
                        {["Alice", "Bob", "Charlie", "David", "Eve"].map((name, index) => (
                            <ListItem key={index}>
                                <ListItemAvatar>
                                    <Avatar>{name.charAt(0)}</Avatar>
                                </ListItemAvatar>
                                <ListItemText primary={name} />
                            </ListItem>
                        ))}
                    </List>
                </Box>
            </Grid>
            <Dialog open={dialogOpen} onClose={handleClose} maxWidth={"sm"} fullWidth={true}>
                <DialogTitle sx={{ bgcolor: "#22264B", color: "white" }}>{selectedPost?.title}</DialogTitle>
                <DialogContent sx={{ bgcolor: "#22264B", color: "white" }}>
                    <Typography>{selectedPost?.definition}</Typography>
                    <Typography>by {selectedPost?.creatorName}</Typography>
                    <Typography>{selectedPost?.postDetails?.length} participants</Typography>
                </DialogContent>
            </Dialog>
        </Grid>
    );
}