"use client";

import React from "react";
import {Box, Button, Icon, Typography, useMediaQuery} from "@mui/material";
import {Logout, Person, RocketLaunch} from "@mui/icons-material";
import NotificationsIcon from "@mui/icons-material/Notifications";
import Link from "next/link";
import {usePathname} from "next/navigation";
import {clearLocalStorage} from "@/service/ApiService";

export default function SideBarComponent() {
    const pathname = usePathname();
    const isMobile = useMediaQuery("(max-width: 991px)");

    return (
        <Box
            sx={{
                position: isMobile ? "fixed" : "block",
                zIndex: "10000",
                bottom: "0",
                width: isMobile ? "100%" : "calc((100vw/12)*2)",
                height: isMobile ? "60px" : "calc(100vh - 64px)",
                boxSizing: "border-box",
                bgcolor: "#1C2357",
                padding: isMobile ? "10px" : "20px 0",
                display: isMobile ? "block" : "flex",
                flexDirection: isMobile ? "row" : "column",
                justifyContent: isMobile ? "space-evenly" : "space-between",
            }}
        >
            <Box sx={{
                display: "flex",
                flexDirection: isMobile ? "row" : "column",
                justifyContent: "space-evenly",
            }}>
                <NavItem
                    href="/FYP"
                    icon={<RocketLaunch/>}
                    label="For You"
                    isMobile={isMobile}
                    active={pathname === "/FYP"}
                />

                <NavItem
                    href="/notification"
                    icon={<NotificationsIcon/>}
                    label="Notifications"
                    isMobile={isMobile}
                    active={pathname === "/notification"}
                />

                <NavItem
                    href="/profile"
                    icon={<Person/>}
                    label="Profile"
                    isMobile={isMobile}
                    active={pathname === "/profile"}
                />
            </Box>

            {
                !isMobile && (
                    <Link onClick={() => {
                        clearLocalStorage();
                    }} href="/api/auth/logout">
                        <Box
                            sx={{
                                cursor: "pointer",
                                width: "100%",
                                padding: "15px 20px 15px 20px",
                                display: "flex",
                                justifyContent: "flex-start",
                                color: "#8691C3",
                            }}
                        >
                            <Icon sx={{color: "#8691C3"}}><Logout/></Icon>
                            <Typography sx={{marginLeft: "10px", fontWeight: "600", fontSize: "20px"}}>LOGOUT</Typography>
                        </Box>
                    </Link>
                )
            }
        </Box>
    );
}

interface NavItemProps {
    href: string;
    icon: React.ReactNode;
    label: string;
    isMobile: boolean;
    active: boolean;
}

function NavItem(props: NavItemProps) {
    return (
        <Link href={props.href} style={{textDecoration: "none"}}>
            <Box
                sx={{
                    cursor: "pointer",
                    width: props.isMobile ? "33%" : "100%",
                    padding: props.isMobile ? "0" : "15px 20px 15px 20px",
                    display: "flex",
                    justifyContent: props.isMobile ? "center" : "flex-start",
                    color: props.active ? "#fff" : "#8691C3",
                }}
            >
                <Icon sx={{color: props.active ? "#fff" : "#8691C3"}}>{props.icon}</Icon>
                {!props.isMobile && (
                    <Typography
                        sx={{marginLeft: "10px", fontWeight: "600", fontSize: "20px"}}>{props.label}</Typography>
                )}
            </Box>
        </Link>
    )
}
