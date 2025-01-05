"use client";
import React, {useEffect, useState} from "react";
import Grid from "@mui/material/Grid2";
import ForYouComponent from "./ForYouComponent";
import CreateComponent from "@/app/FYP/CreateComponent";
import PostComponent from "@/app/FYP/PostComponent";
import {PostModel} from "@/model/model";
import {Box, useMediaQuery} from "@mui/material";
import {getPost, getPosts} from "@/service/post";

export default function Page() {
    const isMobile = useMediaQuery("(max-width: 991px)");
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
        <Grid container height="100%" width="100%" m={3} sx={{overflow: "hidden"}}>
            <Grid size={isMobile ? 12 : 8} component="div">
                <Box
                    sx={{
                        width: "100%",
                        height: isMobile ? "calc(95vh - 64px - 60px)" : "calc(95vh - 64px)",
                        justifyContent: "center",
                        alignItems: "center",
                        backgroundColor: "#22264B",
                        borderRadius: "1em",
                        overflowY: "scroll"
                    }}
                >
                    {
                        showPostComponent && selectedPost ?
                            <PostComponent postData={selectedPost} onGoBack={handleGoBack}/>
                            :
                            <ForYouComponent setShowPostComponent={setShowPostComponent}
                                             setSelectedPost={setSelectedPost} posts={posts} fetchPosts={fetchPosts}
                                             showCreate={isMobile}/>
                    }
                </Box>
            </Grid>
            {
                !isMobile && (
                    <Grid size={4}>
                        <Box
                            sx={{
                                paddingLeft: "1vw",
                                width: "100%",
                                height: isMobile ? "calc(95vh - 64px - 60px)" : "calc(95vh - 64px)",
                            }}
                        >
                            <CreateComponent fetchPosts={fetchPosts}/>
                        </Box>
                    </Grid>
                )
            }
        </Grid>
    );
}