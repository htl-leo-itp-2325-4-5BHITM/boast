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
            mt={12}
            bgcolor="#1A1C40"
            color="white"
            sx={{
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
                overflowY: "scroll",
            }}
        >


            <Box sx={{
                width: "100%",
                borderRadius: "5px",
                padding: "3%",
                backgroundColor: "#22264B",
                display: "flex",
                marginBottom: "5vh"
            }}>
                <Avatar
                    sx={{
                        width: 100,
                        height: 100,
                        bgcolor: "#4ECA31",
                        fontSize: "3rem",
                        margin: "2%",
                    }}>
                    {profile.username[0]}
                </Avatar>
                <Box sx={{margin: "2%"}}>
                    <Typography variant="h5">{profile.username}</Typography>
                    <Box display="flex">
                        <Typography m={1} ml={0} mr={3}>{profile.posts.length} posts</Typography>
                        <Typography m={1} ml={0} mr={3}>{profile.follower} followers</Typography>
                        <Typography m={1} ml={0} mr={3}>{profile.following} following</Typography>
                    </Box>
                    <Typography>{profile.name}</Typography>
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
                </Box>
            </Box>

            <Box sx={{width: "100%", borderRadius: "5px", padding: "3%", backgroundColor: "#22264B"}}>
                <Typography variant="h6" sx={{mb: 2, fontWeight: "bold"}}>
                    Posts
                </Typography>

                <Grid container spacing={2} sx={{
                    overflowY: "scroll"
                }}>
                    {posts.length === 0 ? (
                        <Typography variant="body2" sx={{color: "#C20B4E", textAlign: 'center', width: '100%'}}>
                            No posts yet.
                        </Typography>
                    ) : (

                        posts.map((post, index) => (
                            <Grid item p={0} xs={12} key={index}>
                                <Card sx={{bgcolor: "#51588a", color: "#fff"}}>
                                    <CardContent>
                                        <Box display={"flex"}>
                                            <Typography variant="h6" fontWeight={"bold"} sx={{width: "92%"}}>{post.title}</Typography>
                                            <Box sx={{justifyContent: "right", width: "8%"}} position={"static"} alignItems={"right"} textAlign={"center"}>
                                                <Typography variant="caption" sx={{color: "#C0C0C0"}}>
                                                    {post.createdOn}
                                                </Typography>
                                                <Box bgcolor={post.status == "OPEN" ? "#4ECA31" : "#C20B4E"}
                                                     sx={{borderRadius: "5px", paddingLeft: "5%", paddingRight: "5%", textAlign: "center"}}>
                                                    <Typography>{post.status}</Typography>
                                                </Box>
                                            </Box>
                                        </Box>
                                        <Typography variant="body2">{post.definition}</Typography>
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