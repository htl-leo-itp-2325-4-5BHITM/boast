"use client";
import React, {useState} from "react";
import Grid from "@mui/material/Grid2";
import ForYouComponent from "./ForYouComponent";
import CreateComponent from "@/app/FYP/CreateComponent";
import PostComponent from "@/app/FYP/PostComponent";
import {PostModel} from "@/model/model";
import {Box} from "@mui/material";

export default function Page() {
    const [showPostComponent, setShowPostComponent] = useState(false);
    const [selectedPost, setSelectedPost] = useState<PostModel | null>(null);

    const handleGoBack = () => {
        setShowPostComponent(false);
        setSelectedPost(null);
    };

    return (
        <Grid container height="100%">
            <Grid size={8} component="div">
                <Box
                    sx={{
                        width: "90%",
                        height: "80vh",
                        justifyContent: "center",
                        alignItems: "center",
                        margin: "4em 5% 0 5%",
                        backgroundColor: "#22264B",
                        borderRadius: "1em",
                        overflow: "scroll"
                    }}
                >
                    {
                        showPostComponent && selectedPost ?
                            <PostComponent post={selectedPost} onGoBack={handleGoBack}/>
                            :
                            <ForYouComponent setShowPostComponent={setShowPostComponent}
                                             setSelectedPost={setSelectedPost}/>
                    }
                </Box>
            </Grid>
            <Grid size={4}>
                <Box
                    sx={{
                        width: "90%",
                        justifySelf: "center",
                        alignSelf: "center",
                        mt: "4em",
                    }}
                >
                    <CreateComponent/>
                </Box>
            </Grid>
        </Grid>
    );
}