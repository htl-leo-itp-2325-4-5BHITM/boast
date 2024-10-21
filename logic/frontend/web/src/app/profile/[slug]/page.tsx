"use client";
import { useEffect, useState } from "react";
import { Box, Typography, CircularProgress } from "@mui/material";
import axios from "axios";
import { ProfileModel } from "@/model/model";
import { useUser } from "@/provider/UserProvider";

export default function Page({ params }: { params: { slug: string } }) {
    const [profile, setProfile] = useState<ProfileModel | null>(null);
    const [loading, setLoading] = useState(true);
    const { user } = useUser();

    useEffect(() => {
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

                setProfile(profileResponse.data);
            } catch (error) {
                console.error("Error fetching profile:", error);
            } finally {
                setLoading(false);
            }
        }

        fetchProfile();
    }, [user?.userId, params.slug]);

    if (loading) {
        return <CircularProgress />;
    }

    if (!profile) {
        return <Typography color="error">Error loading profile</Typography>;
    }

    return (
        <Box p={3} bgcolor="#1A1C40" color="white">
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