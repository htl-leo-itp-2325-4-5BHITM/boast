"use client";

import { Drawer, Typography, List, ListItem, ListItemIcon, ListItemText } from "@mui/material";
import { RocketLaunch, Person, Logout } from "@mui/icons-material";
import NotificationsIcon from '@mui/icons-material/Notifications';
import Link from "next/link";
import React from "react";
import { usePathname } from "next/navigation";
import { useMediaQuery } from "@mui/material";

export default function SideBarComponent() {
    const pathname = usePathname();
    const isMobile = useMediaQuery('(max-width: 600px)');

    return (
        <Drawer
            sx={{
                width: isMobile ? "60px" : "calc((100vw/12)*2)",
                flexShrink: 0,
                '& .MuiDrawer-paper': {
                    width: isMobile ? "60px" : "calc((100vw/12)*2)",
                    boxSizing: 'border-box',
                    bgcolor: "#1C2357",
                    height: "calc(100vh - 64px)",
                    paddingTop: "20px",
                },
            }}
            variant="permanent"
            anchor="bottom"
            PaperProps={{ sx: { width: isMobile ? "60px" : "calc((100vw/12)*2)" } }}
        >
            <Link href="/FYP" style={{ textDecoration: 'none', marginLeft: isMobile ? "0" : "2rem", cursor: "pointer" }}>
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <RocketLaunch />
                        </ListItemIcon>
                        {!isMobile && (
                            <ListItemText>
                                <Typography
                                    sx={{ color: pathname === "/FYP" ? "#fff" : "#8691C3", fontWeight: "500", fontSize: "16px" }}
                                >
                                    For You
                                </Typography>
                            </ListItemText>
                        )}
                    </ListItem>
                </List>
            </Link>

            <Link href="/notification" style={{ textDecoration: 'none', marginLeft: isMobile ? "0" : "2rem", cursor: "pointer" }}>
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <NotificationsIcon />
                        </ListItemIcon>
                        {!isMobile && (
                            <ListItemText>
                                <Typography
                                    sx={{ color: pathname === "/notification" ? "#fff" : "#8691C3", fontWeight: "500", fontSize: "16px" }}
                                >
                                    Notifications
                                </Typography>
                            </ListItemText>
                        )}
                    </ListItem>
                </List>
            </Link>

            <Link href="/profile" style={{ textDecoration: 'none', marginLeft: isMobile ? "0" : "2rem", cursor: "pointer" }}>
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <Person />
                        </ListItemIcon>
                        {!isMobile && (
                            <ListItemText>
                                <Typography
                                    sx={{ color: pathname === "/profile" ? "#fff" : "#8691C3", fontWeight: "500", fontSize: "16px" }}
                                >
                                    Profile
                                </Typography>
                            </ListItemText>
                        )}
                    </ListItem>
                </List>
            </Link>

            <Link href="/logout" style={{ textDecoration: 'none', marginTop: "auto", marginLeft: isMobile ? "0" : "2rem" }}>
                <List>
                    <ListItem>
                        <ListItemIcon sx={{ color: "#8691C3" }}>
                            <Logout />
                        </ListItemIcon>
                        {!isMobile && (
                            <ListItemText>
                                <Typography
                                    sx={{ color: "#8691C3", fontWeight: "500", fontSize: "16px" }}
                                >
                                    Logout
                                </Typography>
                            </ListItemText>
                        )}
                    </ListItem>
                </List>
            </Link>
        </Drawer>
    );
}
