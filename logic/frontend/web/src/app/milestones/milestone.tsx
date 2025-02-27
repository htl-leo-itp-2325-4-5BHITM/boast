"use client"

import {Box, Typography, Tooltip} from "@mui/material";
import {useEffect, useState} from "react";
import {MilestoneData} from "@/model/model";
import {DoneAll} from "@mui/icons-material";

function getRandomColor() {
    const letters = "0123456789ABCDEF";
    let color = "#";
    for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

interface MilestoneProps {
    milestone?: MilestoneData
}

export default function Milestone({milestone}: MilestoneProps) {
    const [glowColor, setGlowColor] = useState("#3656FF");

    useEffect(() => {
        setGlowColor(getRandomColor());
    }, []);

    return (
        <Tooltip title={milestone?.description ?? "coming soon..."} sx={{margin: 0}}>
            <Box
                sx={{
                    width: "200px",
                    height: "200px",
                    border: "#fff",
                    borderRadius: "8px",
                    boxShadow: milestone?.isCompleted ? `0 0 10px ${glowColor}` : "0 0 1px #fff",
                    padding: "16px",
                    backgroundColor: "#22264B",
                    color: "white",
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center",
                    textAlign: "center",
                    margin: 0,
                }}
            >
                <Typography
                    sx={{
                        transform: "rotate(45deg)",
                        fontWeight: "bold",
                    }}
                >
                    {milestone?.title ?? "?"}
                    {milestone?.isCompleted && (
                        <DoneAll sx={{ color: "#00ff00", mt: 1 }} />
                    )}
                </Typography>
            </Box>
        </Tooltip>
    );
}