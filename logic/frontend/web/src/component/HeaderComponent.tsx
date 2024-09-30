// src/component/HeaderComponent.tsx
import React from 'react';
import { AppBar, Box, Toolbar, Typography } from "@mui/material";
import AccountCircle from '@mui/icons-material/AccountCircle';
import {useUser} from "@/service/UserContext";

const HeaderComponent = () => {
    const { user } = useUser();

    return (
        <AppBar position="static" sx={{ bgcolor: "#1A1F45" }}>
            <Toolbar sx={{ mx: 3 }} disableGutters>
                <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
                    boast
                </Typography>

                <Box sx={{ display: "flex", flexDirection: "row" }}>
                    <AccountCircle sx={{ fontSize: 50, my: "auto", mx: 1 }} />
                    <Box>
                        <Typography variant="h6" component="div">
                            {user.username}
                        </Typography>
                        <Typography variant="h6" component="div">
                            {user.email}
                        </Typography>
                    </Box>
                </Box>
            </Toolbar>
        </AppBar>
    );
};

export default HeaderComponent;