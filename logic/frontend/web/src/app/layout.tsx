import {Box, CssBaseline} from "@mui/material";
import HeaderComponent from "@/component/HeaderComponent";
import React from "react";
import SideBarComponent from "@/component/SideBarComponent";
import {UserProvider} from "@/provider/UserProvider";

export default function RootLayout({ children }: { children: React.ReactNode }) {
    return (
        <html>
        <body style={{ backgroundColor: "#1A1C40" }}>
        <UserProvider>
            <Box sx={{ height: "100vh", width: "100vw", overflow: "hidden", backgroundColor: "#1A1C40" }}>
                <CssBaseline />
                <HeaderComponent />
                <Box sx={{ display: "flex", flexDirection: "row", height: "calc(100vh - 64px)", width: "100vw", marginTop: "64px" }}>
                    <SideBarComponent />
                    {children}
                </Box>
            </Box>
        </UserProvider>
        </body>
        </html>
    );
}