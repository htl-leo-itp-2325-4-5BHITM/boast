"use client";
import {Avatar, Box, Card, CardContent, CircularProgress, Typography} from "@mui/material";
import React, {useEffect, useState} from "react";
import {UserModel} from "@/model/model";
import axios from "axios";
import {useUser} from "@/provider/UserProvider";
import Link from "next/link";

export default function Page({params}: { params: { userToSearch: string } }) {

    const [loading, setLoading] = useState(true);
    const [followerIds, setFollowerIds] = useState<Array<string>>([]);
    const [follower, setFollower] = useState<Array<UserModel>>([]);
    const {user} = useUser();

    useEffect(() => {
        async function fetchProfile() {

            try {
                // First request to get the user ID
                const searchResponse = await axios.get(`https://www.boast.social/api/users/search/${params.userToSearch}`, {
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

                console.log(params.userToSearch)
                const followersResponse = await axios.get(`https://www.boast.social/api/relations/following/${userId}`)
                console.log(followersResponse.data)
                setFollowerIds(followersResponse.data)
                console.log(followerIds);

                const actualFollowers = await Promise.all(followersResponse.data.map((followerId: string) =>
                    axios.get(`https://www.boast.social/api/users/${followerId}`)
                ));
                console.log(actualFollowers);
                setFollower(actualFollowers.map(res => res.data));


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

    return (
        <Box p={3} sx={{
            color: "#fff",
            width: "100%",
        }}>
            {follower.length === 0 ? (
                <Typography variant="body2" sx={{color: "#C20B4E", textAlign: 'center', width: '100%'}}>
                    No followers yet.
                </Typography>
            ) : (
                <>
                <Typography variant="h4" sx={{color: "#fff", textAlign: 'center', width: '100%', marginBottom: "1vh"}}>
                    {params.userToSearch} follows
                </Typography>
                {
                    follower.map((follower, index) => (
                        <Card key={index}
                              sx={{
                                  bgcolor: "#51588a",
                                  color: "#fff",
                                  margin: "auto",
                                  marginBottom: "2%",
                                  alignItems: "center",
                                  justifyContent: "center",
                                  borderRadius: "1vw"
                              }}>
                            <CardContent sx={{alignItems: "center", justifyContent: "center"}}>
                                <Link href={"/profile/" + follower.username} style={{textDecoration: "none"}}>
                                    <Box display={"flex"} sx={{justifyContent: "center", alignItems: "center"}}>
                                        <Avatar
                                            sx={{
                                                width: {sm: 100, xs: 50},
                                                height: {sm: 100, xs: 50},
                                                bgcolor: "#4ECA31",
                                                fontSize: {sm: "3rem", xs: "2rem"},
                                                marginRight: "15%"
                                            }}>
                                            {follower.username[0]}
                                        </Avatar>
                                        <Typography variant="h6" fontWeight={"bold"}
                                                    sx={{
                                                        width: {sm: "92%", xs: "72%"},
                                                        alignItems: "center",
                                                        justifyContent: "center",
                                                        color: "#FFF",
                                                    }}>
                                            {follower.username}
                                        </Typography>
                                    </Box>
                                </Link>
                            </CardContent>
                        </Card>
                    ))
                }
                </>
            )}
        </Box>
    )
}