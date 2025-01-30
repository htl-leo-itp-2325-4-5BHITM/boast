'use client';

import React, {useEffect, useState} from "react";
import {Button, CircularProgress, Container, Typography} from "@mui/material";
import {checkAuth} from "@/service/ApiService";
import {usePathname, useRouter} from "next/navigation";
import {Box} from "@mui/system";
import {AuthUser} from "@/model/model";
import AccountCircle from "@mui/icons-material/AccountCircle";

export default function HeaderAuth() {
    const [authUser, setAuthUser] = useState({} as AuthUser);
    const [isLoading, setIsLoading] = useState(true);
    const [isLoggedIn, setIsLoggedIn] = useState(false);
    const pathname = usePathname();
    const router = useRouter();

    useEffect(() => {
        // @ts-ignore
        const authUser: AuthUser | null = checkAuth();
        if (pathname !== "/login-success") {
            if (authUser !== null) {
                setAuthUser(authUser);
                setIsLoggedIn(true);
                setIsLoading(false);
            } else {
                if (pathname !== "/") {
                    router.push('/');
                }
                setAuthUser({} as AuthUser);
                setIsLoggedIn(false);
                setIsLoading(false);
            }
        }
    }, [pathname]);

    if (isLoading)
        return <Container sx={{
            marginRight: "0px",
            height: "100%",
            display: "flex",
            flexDirection: "column",
            justifyContent: "center",
            alignItems: "right",
            width: "fit-content",
        }}>
            <Button sx={{
                padding: "0px",
            }} variant="contained">
                <CircularProgress sx={{
                    padding: "15%",
                }} color="secondary"/>
            </Button>
        </Container>;
    if (isLoggedIn) {
        return (
            <>
                <Box sx={{flexGrow: 1}}></Box>
                <Box sx={{display: "flex", flexDirection: "row", alignItems: "center"}}>
                    <AccountCircle sx={{fontSize: 50, mx: 1}}/>
                    <Box>
                        <Typography variant="h6" component="div">
                            {authUser?.username}
                        </Typography>
                        <Typography variant="h6" component="div">
                            {authUser?.name}
                        </Typography>
                    </Box>
                </Box>
            </>
        )
    }
    return (<>
        <Box sx={{flexGrow: 1}}></Box>
        <Button sx={{display: "flex", flexDirection: "row", alignItems: "center"}}  href="/api/auth/login">
            <Box>
                <Typography variant="h6" component="div">
                    Login
                </Typography>
            </Box>
        </Button>
    </>);
}