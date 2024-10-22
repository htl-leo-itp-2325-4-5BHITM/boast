"use client";

import { Drawer, Typography, List, ListItem, ListItemIcon, ListItemText } from "@mui/material";
import { RocketLaunch, Person, Logout } from "@mui/icons-material";
import NotificationsIcon from '@mui/icons-material/Notifications';
import Link from "next/link";
import React from "react";
import {usePathname} from "next/navigation";

export default function SideBarComponent() {
    const pathname = usePathname();

    console.log(pathname)

    return (
        <Drawer
            sx={{
                width: "calc((100vw/12)*2)",
                flexShrink: 0,
                '& .MuiDrawer-paper': {
                    width: "calc((100vw/12)*2)",
                    boxSizing: 'border-box',
                    bgcolor: "#1C2357",
                    height: "calc(100vh - 64px)",
                    paddingTop: "20px",
                },
            }}
            variant="permanent"
            anchor="bottom"
            PaperProps={{ sx: { width: "calc((100vw/12)*2)" } }}
        >

            {/* For You Section */}
            <Link href="/FYP" style={{ textDecoration: 'none', marginLeft: "2rem"}} >
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <RocketLaunch />
                        </ListItemIcon>
                        <ListItemText>
                            <Typography
                                sx={{ color: pathname === "/FYP" ? "#fff" : "#8691C3", fontWeight: "500", fontSize: "16px" }}
                            >
                                For You
                            </Typography>
                        </ListItemText>
                    </ListItem>
                </List>
            </Link>

            {/* Notification Section */}
            <Link href="/notification" style={{ textDecoration: 'none', marginLeft: "2rem" }}>
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <NotificationsIcon />
                        </ListItemIcon>
                        <ListItemText>
                            <Typography
                                sx={{ color: pathname === "/notification" ? "#fff" : "#8691C3", fontWeight: "500", fontSize: "16px" }}
                            >
                                Notifications
                            </Typography>
                        </ListItemText>
                    </ListItem>
                </List>
            </Link>

            {/* Profile Section */}
            <Link href="/profile" style={{ textDecoration: 'none', marginLeft: "2rem" }}>
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <Person />
                        </ListItemIcon>
                        <ListItemText>
                            <Typography
                                sx={{ color: pathname === "/profile" ? "#fff" : "#8691C3", fontWeight: "500", fontSize: "16px" }}
                            >
                                Profile
                            </Typography>
                        </ListItemText>
                    </ListItem>
                </List>
            </Link>


            {/* Logout Section */}
            <Link href="/logout" style={{ textDecoration: 'none', marginTop: "auto", marginLeft: "2rem" }}>
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <Logout />
                        </ListItemIcon>
                        <ListItemText>
                            <Typography
                                sx={{ color: "#8691C3", fontWeight: "500", fontSize: "16px" }}
                            >
                                Logout
                            </Typography>
                        </ListItemText>
                    </ListItem>
                </List>
            </Link>
        </Drawer>
    );
}
