// src/app/profile/page.tsx
"use client";
import { useEffect, useState } from "react";
import { Box, Typography, CircularProgress } from "@mui/material";
import axios from "axios";
import { ProfileModel } from "@/model/model";
import {useUser} from "@/provider/UserProvider";

export default function Page() {
    const [profile, setProfile] = useState<ProfileModel | null>(null);
    const [loading, setLoading] = useState(true);
    const {user} = useUser()

    useEffect(() => {
        async function fetchProfile() {
            try {
                const response = await axios.get(`https://www.boast.social/api/users/profile/${user?.userId}`, {
                    headers: {
                        'reqUserId': user?.userId.toString(),
                        'accept': '*/*'
                    }
                });
                setProfile(response.data);
            } catch (error) {
                console.error("Error fetching profile:", error);
            } finally {
                setLoading(false);
            }
        }

        fetchProfile();
    }, [user?.userId]);

    if (loading) {
        return <CircularProgress />;
    }

    if (!profile) {
        return <Typography color="error">Error loading profile</Typography>;
    }

    return (
        <Box p={3} bgcolor="#1A1C40" color="white" sx={{}}>
            <Typography variant="h4">Profile Page</Typography>
            <Typography variant="h6">Username: {profile.username}</Typography>
            <Typography variant="body1">User ID: {profile.userId}</Typography>
            <Typography variant="body1">Created On: {new Date(profile.createdOn).toLocaleString()}</Typography>
            <Typography variant="body1">Follower: {profile.follower}</Typography>
            <Typography variant="body1">Following: {profile.following}</Typography>
            <Typography variant="body1">Relation Status: {profile.relationStatus}</Typography>
            <Typography variant="h6">Posts:</Typography>
            <ul>
                {profile.posts.map(postId => (
                    <li key={postId}>{postId}</li>
                ))}
            </ul>
        </Box>
    );
}