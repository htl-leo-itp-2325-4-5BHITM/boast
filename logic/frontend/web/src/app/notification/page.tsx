"use client"
import React, {useEffect, useState} from "react";
import {Box, List, ListItem, Typography, useMediaQuery} from "@mui/material";
import {getData} from "@/service/ApiService";

interface Notification {
    notificationId: number;
    createdOn: string;
    description: string;
    notificationType: string;
    read: boolean;
    header?: string;
    postId?: number;
    sendingUserId?: number;
    sendingUserName?: string;
}

export default function Page() {
    const isMobile = useMediaQuery("(max-width: 991px)");
    const [notifications, setNotifications] = useState<Notification[]>([]);

    const colors = ["#3656FF", "#C20B4E", "#4ECA31"]

    useEffect(() => {
        const fetchNotifications = async () => {
            try {
                const response = await getData<number[]>('/notifications');

                const notificationResponses = await Promise.all(response.map((notificationId: number) =>
                    getData<Notification>(`/notifications/${notificationId}`)
                ));

                setNotifications(notificationResponses);
                console.log(notificationResponses)
            } catch (error) {
                console.error("Error fetching notifications:", error);
            }
        };

        fetchNotifications();
    }, []);

    const userNotifications = notifications.filter(notification => notification.notificationType === "USER");

    return (
        <Box m={3} color={"white"} sx={{
            width: "100%",
            borderRadius: "1vw",
            padding: "3%",
            backgroundColor: "#22264B",
            height: isMobile ? "calc(95vh - 64px - 60px)" : "calc(95vh - 64px)",
            overflow: "hidden"
        }}>
            <Typography variant="h4" sx={{
                height: "4vh"
            }}>{userNotifications.length} Notifications</Typography>
            <List sx={{
                height: isMobile ? "calc(90vh - 64px - 60px)" : "calc(90vh - 64px)",
                overflow: "scroll",
                paddingBottom: "10vh"
            }}>
                {userNotifications.length === 0 && (
                    <Typography component="span" color="grey">
                        No notifications yet
                    </Typography>
                )}

                {userNotifications.map((notification, index) => (
                    <ListItem key={Math.random()} sx={{
                        bgcolor: "#51588a",
                        color: "#fff",
                        border: "2px solid",
                        borderColor: colors[index % colors.length],
                        borderRadius: "5px",
                        marginBottom: "2%",
                        width: "100%"
                    }}>
                        <Box sx={{
                            width: "100%",
                        }}>
                            <Typography fontWeight={"bold"}>
                                {notification.description.split(":")[0]}
                            </Typography>
                            <Box display="flex" justifyContent="space-between">
                                <Typography>{notification.sendingUserName} voted: {notification.description.split(":")[1]}</Typography>
                                <Typography align={"right"}>
                                    {notification.createdOn}
                                </Typography>
                            </Box>
                        </Box>
                    </ListItem>
                ))}
            </List>
        </Box>
    );
}