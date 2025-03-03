"use client"

import {Box} from "@mui/material";
import Milestone from "@/app/milestones/milestone";
import {useEffect, useState} from "react";
import {getData} from "@/service/ApiService";
import {MilestoneData} from "@/model/model";


export default function Page() {
    const [milestones, setMilestones] = useState<MilestoneData[]>([]);

    useEffect(() => {
        const fetchMilestones = async () => {
            try {
                const response = await getData<MilestoneData[]>('/milestone');
                setMilestones(response);
                console.log(response)
            } catch (error) {
                console.error("Error fetching milestones:", error);
            }
        };

        fetchMilestones();
    }, []);

    const boxes = Array.from({ length: 5 }, (_, index) => [
        { top: index * 210, left: (index) * 210 },
        { top: index * 210, left: (index+1) * 210 },
    ]).flat();

    return (
        <Box
            sx={{
                width: "100%",
                height: "100%",
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                overflowX: "auto",
                overflowY: "hidden",
            }}
        >
            <Box
                sx={{
                    position: "relative",
                    display: "flex",
                    flexWrap: "wrap",
                    transform: "rotate(-45deg)",
                    ml: "-80vw"
                }}
            >
                {boxes.map((pos, index) => (
                    <Box
                        key={index}
                        sx={{
                            position: "absolute",
                            top: `${pos.top}px`,
                            left: `${pos.left}px`,
                        }}
                    >
                        <Milestone milestone={milestones[index]} />
                    </Box>
                ))}
            </Box>
        </Box>
    );
}