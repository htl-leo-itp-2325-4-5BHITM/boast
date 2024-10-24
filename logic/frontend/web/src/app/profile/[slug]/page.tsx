"use client";
import React, {useEffect, useState} from "react";
import {Box, Typography, CircularProgress, Avatar, Grid, Button, Card, CardContent} from "@mui/material";
import axios from "axios";
import {useUser} from "@/provider/UserProvider";
import {ProfileModel, PostModel} from "@/model/model";

export default function Page({params}: { params: { slug: string } }) {
    const [profile, setProfile] = useState<ProfileModel | null>(null);
    const [posts, setPosts] = useState<Array<PostModel>>([]);
    const [loading, setLoading] = useState(true);
    const {user} = useUser();

    async function fetchProfile() {
        try {
            // First request to get the user ID
            const searchResponse = await axios.get(`https://www.boast.social/api/users/search/${params.slug}`, {
                headers: {
                    'reqUserId': user?.userId.toString(),
                    'accept': '*/*'
                }
            });

            const userId = searchResponse.data[0]?.userId;
            if (!userId) {
                throw new Error("User ID not found");
            }

            // Second request to get the profile details
            const profileResponse = await axios.get(`https://www.boast.social/api/users/profile/${userId}`, {
                headers: {
                    'reqUserId': user?.userId.toString(),
                    'accept': '*/*'
                }
            });

            console.log(profileResponse.data)

            const postIds = profileResponse.data.posts;
            const postResponses = await Promise.all(postIds.map((postId: number) =>
                axios.get(`https://www.boast.social/api/posts/${postId}`)
            ));

            setPosts(postResponses.map(res => res.data));

            setProfile(profileResponse.data);
        } catch (error) {
            console.error("Error fetching profile:", error);
        } finally {
            setLoading(false);
        }
    }

    useEffect(() => {
        fetchProfile();
    }, [user?.userId, params.slug]);

    if (loading) {
        return <CircularProgress/>;
    }

    if (!profile) {
        return <Typography color="error">Error loading profile</Typography>;
    }

    const followToggle = () => {
        axios.post(`https://www.boast.social/api/relations/${profile.relationStatus === "NO_RELATION" ? "follow" : "unfollow"}/${profile.userId}`, {}, {
            headers: {
                'reqUserId': user?.userId.toString(),
                'accept': '*/*'
            }
        }).then(() => {
            console.log("User followed/unfollowed successfully");
            fetchProfile()
        }).catch(error => {
            console.error("Error following user:", error);
        })
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
                overflowY: "scroll",
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

                    {
                        profile.userId !== user?.userId && (
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
                        )
                    }
                </Grid>
            </Grid>

            <Box sx={{width: "100%", maxWidth: "800px"}}>
                <Typography variant="h6" sx={{mb: 2}}>
                    Posts
                </Typography>

                <Grid container spacing={2} sx={{
                    height: "71vh",
                    overflowY: "scroll"
                }}>
                    {posts.length === 0 ? (
                        <Typography variant="body2" sx={{color: "#C20B4E", textAlign: 'center', width: '100%'}}>
                            No posts yet.
                        </Typography>
                    ) : (
                        posts.map((post, index) => (
                            <Grid item xs={12} key={index}>
                                <Card sx={{bgcolor: "#2E2F55", color: "#fff"}}>
                                    <CardContent>
                                        <Typography variant="h6">{post.title}</Typography>
                                        <Typography variant="body2">{post.definition}</Typography>
                                        <Box display="flex" justifyContent="space-between" alignItems="center" mt={2}>
                                            <Typography variant="caption" sx={{color: "#C0C0C0"}}>
                                                {post.createdOn}
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
                    <br/><br/>
                </Grid>
            </Box>
        </Box>
    );
}