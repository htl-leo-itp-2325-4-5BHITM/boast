"use client";
import {useEffect, useState} from "react";
import {Box, Typography, CircularProgress, Avatar, Grid, Card, CardContent} from "@mui/material";
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

                console.log(postResponses)

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
