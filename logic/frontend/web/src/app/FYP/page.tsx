"use client";
import React, {useEffect, useState} from "react";
import Grid from "@mui/material/Grid2";
import ForYouComponent from "./ForYouComponent";
import CreateComponent from "@/app/FYP/CreateComponent";
import PostComponent from "@/app/FYP/PostComponent";
import {PostModel} from "@/model/model";
import {Box} from "@mui/material";
import {getPost, getPosts} from "@/service/post";

export default function Page() {
    const [showPostComponent, setShowPostComponent] = useState(false);
    const [selectedPost, setSelectedPost] = useState<PostModel | null>(null);
    const [posts, setPosts] = useState<PostModel[]>([]);

    const fetchPosts = async () => {
        try {
            const postIds = await getPosts();
            const postDetails = await Promise.all(postIds.map(id => getPost(id)));
            setPosts(postDetails);
        } catch (error) {
            console.error('Error fetching posts:', error);
        }
    };

    const handleGoBack = () => {
        setShowPostComponent(false);
        setSelectedPost(null);
    };

    useEffect(() => {
        fetchPosts();
    }, []);

    return (
        <Grid container height="100%" mt={8} sx={{overflow: "hidden"}}>
            <Grid size={8} component="div">
                <Box
                    sx={{
                        width: "85%",
                        height: "80vh",
                        justifyContent: "center",
                        alignItems: "center",
                        margin: "4em 5% 0 5%",
                        backgroundColor: "#22264B",
                        borderRadius: "1em",
                        mx: "auto",
                        overflowY: "scroll"
                    }}
                >
                    {
                        showPostComponent && selectedPost ?
                            <PostComponent postData={selectedPost} onGoBack={handleGoBack}/>
                            :
                            <ForYouComponent setShowPostComponent={setShowPostComponent}
                                             setSelectedPost={setSelectedPost} posts={posts} fetchPosts={fetchPosts}/>
                    }
                </Box>
            </Grid>
            <Grid size={4}>
                <Box
                    sx={{
                        mt: "4em",
                        mx: "auto",
                    }}
                >
                    <CreateComponent fetchPosts={fetchPosts} />
                </Box>
            </Grid>
        </Grid>
    );
}