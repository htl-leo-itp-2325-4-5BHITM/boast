"use client";
import {useEffect, useState} from "react";
import {Box, Typography, CircularProgress, Avatar, Grid, Button, Card, CardContent} from "@mui/material";
import axios from "axios";
import {useUser} from "@/provider/UserProvider";
import {ProfileModel, PostModel} from "@/model/model";

export default function Page() {
    const [profile, setProfile] = useState<ProfileModel | null>(null);
    const [posts, setPosts] = useState<Array<PostModel>>([]);
    const [loading, setLoading] = useState(true);
    const {user} = useUser();

    useEffect(() => {
        async function fetchProfile() {
            try {
                const response = await axios.get(`https://www.boast.social/api/users/profile/${user?.userId}`, {
                    headers: {
                        reqUserId: user?.userId.toString(),
                        accept: "*/*",
                    },
                });
                setProfile(response.data);

                const postIds = response.data.posts;
                const postResponses = await Promise.all(postIds.map((postId: number) =>
                    axios.get(`https://www.boast.social/api/posts/${postId}`)
                ));

                setPosts(postResponses.map(res => res.data));
            } catch (error) {
                console.error("Error fetching profile or posts:", error);
            } finally {
                setLoading(false);
            }
        }

        fetchProfile();
    }, [user?.userId]);

    if (loading) {
        return (
            <Box display="flex" justifyContent="center" alignItems="center" height="100vh">
                <CircularProgress sx={{color: "#3635FF"}}/>
            </Box>
        );
    }

    if (!profile) {
        return (
            <Typography color="error" align="center" variant="h6">
                Error loading profile
            </Typography>
        );
    }

    const followToggle = () => {
        console.log(profile.relationStatus === 'NO_RELATION' ? 'Following user' : 'Unfollowing user');
    };

    return (
        <Box
            p={3}
            bgcolor="#1A1C40"
            color="white"
            sx={{
                minHeight: "100vh",
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
            }}
        >
            <Grid container spacing={2} justifyContent="center" alignItems="center" sx={{mb: 4, width: '100%'}}>
                <Grid item xs={12} sm={3} display="flex" justifyContent="center">
                    <Avatar
                        sx={{
                            width: 100,
                            height: 100,
                            bgcolor: "#4ECA31",
                            fontSize: "3rem",
                        }}
                    >
                        {profile.username[0]}
                    </Avatar>
                </Grid>
                <Grid item xs={12} sm={9}>
                    <Typography variant="h5">{profile.username}</Typography>
                    <Typography variant="body2">{profile.follower} followers
                        · {profile.following} following</Typography>
                    <Typography variant="body2">{profile.name}</Typography>

                    <Button
                        variant="contained"
                        onClick={followToggle}
                        sx={{
                            mt: 2,
                            bgcolor: profile.relationStatus === 'NO_RELATION' ? "#4ECA31" : "#C20B4E",
                            ":hover": {bgcolor: profile.relationStatus === 'NO_RELATION' ? "#4ECA31" : "#C20B4E"},
                        }}
                    >
                        {profile.relationStatus === 'NO_RELATION' ? "Follow" : "Unfollow"}
                    </Button>
                </Grid>
            </Grid>

            <Box sx={{width: "100%", maxWidth: "800px"}}>
                <Typography variant="h6" sx={{mb: 2}}>
                    Posts
                </Typography>

                <Grid container spacing={2}>
                    {posts.length === 0 ? (
                        <Typography variant="body2" sx={{color: "#C20B4E", textAlign: 'center', width: '100%'}}>
                            No posts yet.
                        </Typography>
                    ) : (
                        posts.map((post, index) => (
                            <Grid item xs={12} key={index}>
                                <Card sx={{bgcolor: "#2E2F55"}}>
                                    <CardContent>
                                        <Typography variant="h6">{post.title}</Typography>
                                        <Typography variant="body2">{post.definition}</Typography>
                                        <Box display="flex" justifyContent="space-between" alignItems="center" mt={2}>
                                            <Typography variant="caption" sx={{color: "#C0C0C0"}}>
                                                {new Date(post.createdOn).toLocaleString()}
                                            </Typography>
                                            <Button
                                                variant="outlined"
                                                sx={{
                                                    borderColor: post.status === "ACTIVE" ? "#4ECA31" : "#C20B4E",
                                                    color: post.status === "ACTIVE" ? "#4ECA31" : "#C20B4E",
                                                }}
                                            >
                                                {post.status === "ACTIVE" ? "Active" : "Inactive"}
                                            </Button>
                                        </Box>
                                    </CardContent>
                                </Card>
                            </Grid>
                        ))
                    )}
                </Grid>
            </Box>
        </Box>
    );
}
