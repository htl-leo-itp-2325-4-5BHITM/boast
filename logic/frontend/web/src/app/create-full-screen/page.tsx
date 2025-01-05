"use client";

import CreateComponent from "@/app/FYP/CreateComponent";
import {useRouter} from "next/navigation";
import {Box} from "@mui/material";

export default function Page() {
    const router = useRouter();

    return (
        <Box
            p={3}
            sx={{
                width: "100%",
                height: "calc(95vh - 64px - 60px)",
            }}
        >
            <CreateComponent fetchPosts={() => {
                router.push("/FYP")
            }}/>
        </Box>

    )
}