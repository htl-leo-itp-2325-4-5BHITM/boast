"use client"
import SideBarComponent from "@/component/SideBarComponent";
import { CssBaseline } from "@mui/material";
import Grid from '@mui/material/Grid2';
import HeaderComponent from "@/component/HeaderComponent";
import React, { useState } from "react";
import {UserProvider} from "@/service/UserContext";

export default function RootLayout({ children }: { children: React.ReactNode }) {
    const [user, setUser] = useState({ username: "username", email: "email" });

    return (
        <html>
        <body>
        <UserProvider>
            <CssBaseline />
            <Grid container height="100vh" overflow="hidden" bgcolor="#1A1C40">
                <Grid size={12}>
                    <HeaderComponent username={user.username} email={user.email} />
                </Grid>
                <Grid size={2}>
                    <SideBarComponent />
                </Grid>
                <Grid size={10} sx={{ overflow: "auto", height: "100vh" }}>
                    {React.cloneElement(children as React.ReactElement, { setUser })}
                </Grid>
            </Grid>
        </UserProvider>
        </body>
        </html>
    );
}