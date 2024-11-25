import { Box, CssBaseline } from "@mui/material";
import HeaderComponent from "@/component/HeaderComponent";
import React from "react";
import SideBarComponent from "@/component/SideBarComponent";
import Grid from "@mui/material/Grid2";
import { UserProvider } from "@/provider/UserProvider";

export default function RootLayout({ children }: { children: React.ReactNode }) {
    return (
        <html>
        <body style={{ backgroundColor: "#1A1C40" }}>
        <UserProvider>
            <Box sx={{ height: "100vh", width: "100vw", overflow: "hidden", backgroundColor: "#1A1C40" }}>
                <CssBaseline />
                <HeaderComponent />
                <SideBarComponent />
                <Grid container sx={{ height: "100vh" }}>
                    <Grid size={2}><Box></Box></Grid>
                    <Grid size={10} bgcolor="#1A1C40">
                        {children}
                    </Grid>
                </Grid>
            </Box>
        </UserProvider>
        </body>
        </html>
    );
}