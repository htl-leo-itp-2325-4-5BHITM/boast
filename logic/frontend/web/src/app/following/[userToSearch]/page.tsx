"use client";
import {Avatar, Box, Card, CardContent, CircularProgress, Typography} from "@mui/material";
import React, {useEffect, useState} from "react";
import {ProfileModel, UserModel} from "@/model/model";
import axios from "axios";
import Link from "next/link";
import {getData} from "@/service/ApiService";

export default function Page({params}: { params: { userToSearch: string } }) {

    const [loading, setLoading] = useState(true);
    const [followerIds, setFollowerIds] = useState<Array<string>>([]);
    const [follower, setFollower] = useState<Array<UserModel>>([]);

    useEffect(() => {
        async function fetchProfile() {

            try {
                const response = await getData<ProfileModel>(`/users/profile/username/${params.userToSearch}`);

                const followingResponse = await getData<string[]>(`/relations/following/${response.userId}`)
                setFollowerIds(followingResponse)
                console.log(followerIds);

                const actualFollowings = await Promise.all(followingResponse.map((followerId: string) =>
                    getData<UserModel>(`/users/${followerId}`)
                ));
                setFollower(actualFollowings);

            } catch (error) {
                console.error("Error fetching profile or posts:", error);
            } finally {
                setLoading(false);
            }
        }

        fetchProfile();
    }, []);

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