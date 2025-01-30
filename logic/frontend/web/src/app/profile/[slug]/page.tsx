"use client";
import React, {useEffect, useState} from "react";
import {Avatar, Box, Button, Card, CardContent, CircularProgress, Typography} from "@mui/material";
import axios from "axios";
import {PostModel, ProfileModel} from "@/model/model";
import Link from "next/link";
import {checkAuth, getData, postData} from "@/service/ApiService";

export default function Page({params}: { params: { slug: string } }) {
    const [profile, setProfile] = useState<ProfileModel | null>(null);
    const [posts, setPosts] = useState<Array<PostModel>>([]);
    const [loading, setLoading] = useState(true);

    async function fetchProfile() {
        try {
            const response = await getData<ProfileModel>(`/users/profile/username/${params.slug}`);
            setProfile(response);
            console.log(response)

            const postIds = response.posts;
            const postResponses = await Promise.all(postIds.map((postId: number) =>
                getData<PostModel>(`/posts/${postId}`)
            ));

            console.log(postResponses)

            setPosts(postResponses);
        } catch (error) {
            console.error("Error fetching profile:", error);
        } finally {
            setLoading(false);
        }
    }

    useEffect(() => {
        fetchProfile();
    }, [params.slug]);

    if (loading) {
        return <CircularProgress/>;
    }

    if (!profile) {
        return <Typography color="error">Error loading profile</Typography>;
    }

    const followToggle = () => {
        postData<any>(`/relations/${profile.relationStatus === "NO_RELATION" ? "follow" : "unfollow"}/${profile.userId}`, {}).then(() => {
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
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
                overflowY: "scroll",
                width: "100%",
            }}
        >


            <Box sx={{
                width: "100%",
                borderRadius: "5px",
                padding: "3%",
                backgroundColor: "#22264B",
                display: "flex",
                marginBottom: "5vh",
            }}>
                <Avatar
                    sx={{
                        width: {sm: 100, xs: 50},
                        height: {sm: 100, xs: 50},
                        bgcolor: "#4ECA31",
                        fontSize: {sm: "3rem", xs: "2rem"},
                        margin: "2%",
                    }}>
                    {profile.username[0]}
                </Avatar>
                <Box sx={{margin: "2%"}}>
                    <Typography variant="h5">{profile.username}</Typography>
                    <Box display="flex">
                        <Typography sx={{
                            fontSize: {sm: "1rem", xs: "0.7rem"},
                            margin: 1,
                            marginLeft: 0,
                            marginRight: {sm: 3, xs: 1.5},
                        }}>
                            {profile.posts.length} posts
                        </Typography>
                        <Link href={`/follower/${profile.username}`} passHref style={{textDecoration: "none"}}>
                            <Typography sx={{
                                fontSize: {sm: "1rem", xs: "0.7rem"},
                                margin: 1,
                                marginLeft: 0,
                                marginRight: {sm: 3, xs: 1.5},
                                color: "white",
                                textDecoration: "none",
                            }}>
                                {profile.follower} follower
                            </Typography>
                        </Link>
                        <Link href={`/following/${profile.username}`} style={{textDecoration: "none"}}>
                            <Typography sx={{
                                fontSize: {sm: "1rem", xs: "0.7rem"},
                                margin: 1,
                                marginLeft: 0,
                                marginRight: {sm: 3, xs: 1.5},
                                color: "white",
                                textDecoration: "none",
                            }}>
                                {profile.following} following
                            </Typography></Link>
                    </Box>
                    <Typography>{profile.name}</Typography>
                    {
                        profile.userId !== checkAuth()?.userId && (
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

                <Box sx={{
                    overflowY: "scroll",
                    height: {sm: "40vh", xs: "52vh"},
                }}>
                    {posts.length === 0 ? (
                        <Typography variant="body2" sx={{color: "#C20B4E", textAlign: 'center', width: '100%'}}>
                            No posts yet.
                        </Typography>
                    ) : (
                        posts.map((post, index) => (
                            <Card key={index} sx={{bgcolor: "#51588a", color: "#fff", marginBottom: "2%"}}>
                                <CardContent>
                                    <Box display={"flex"}>
                                        <Typography variant="h6" fontWeight={"bold"}
                                                    sx={{width: {sm: "92%", xs: "72%"}}}>
                                            {post.title}
                                        </Typography>
                                        <Box
                                            sx={{
                                                justifyContent: "right",
                                                width: {sm: "8%", xs: "28%"}
                                            }}
                                            position={"static"}
                                            alignItems={"right"} textAlign={"center"}>
                                            <Typography variant="caption" sx={{color: "#C0C0C0"}}>
                                                {post.createdOn}
                                            </Typography>
                                            <Box bgcolor={post.status == "OPEN" ? "#4ECA31" : "#C20B4E"}
                                                 sx={{
                                                     borderRadius: "5px",
                                                     paddingLeft: "5%",
                                                     paddingRight: "5%",
                                                     textAlign: "center"
                                                 }}>
                                                <Typography>{post.status}</Typography>
                                            </Box>
                                        </Box>
                                    </Box>
                                    <Typography variant="body2">{post.definition}</Typography>
                                </CardContent>
                            </Card>
                        ))
                    )}
                    <br/><br/>
                </Box>
            </Box>
        </Box>
    );
}
