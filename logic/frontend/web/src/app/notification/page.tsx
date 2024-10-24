"use client"
import React, { useEffect, useState } from "react";
import axios from "axios";
import { useUser } from "@/provider/UserProvider";
import { Box, List, ListItem, ListItemText, Typography } from "@mui/material";

interface Notification {
    id: string;
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
    const { user } = useUser();
    const [notifications, setNotifications] = useState<Notification[]>([]);

    useEffect(() => {
        const fetchNotifications = async () => {
            try {
                const userId = user?.userId || '';
                const response = await axios.get('https://www.boast.social/api/notifications', {
                    headers: {
                        'accept': '*/*',
                        'reqUserId': userId,
                    }
                });

                const notificationIds = response.data;
                const notificationPromises = notificationIds.map((id: string) =>
                    axios.get(`https://www.boast.social/api/notifications/${id}`, {
                        headers: {
                            'accept': '*/*',
                            'reqUserId': userId,
                        }
                    })
                );

                const notificationResponses = await Promise.all(notificationPromises);
                const notificationsData = notificationResponses.map((res) => res.data);
                setNotifications(notificationsData);
                console.log(notificationsData)
            } catch (error) {
                console.error("Error fetching notifications:", error);
            }
        };

        fetchNotifications();
    }, [user]);

    return (
        <Box p={3} bgcolor="#1A1C40" color="white" borderRadius="8px">
            <Typography variant="h4" mb={2}>Notifications</Typography>
            <List>
                {
                    notifications.length === 0 && (
                        <Typography component="span" color="grey">
                            No notifications yet
                        </Typography>
                    )
                }

                {notifications.map((notification) => (
                    <ListItem key={notification.id} sx={{ bgcolor: "#22264B", mb: 1, borderRadius: "8px" }}>
                        <ListItemText
                            primary={notification.header || notification.description}
                            secondary={
                                <>
                                    <Typography component="span" variant="body2" color="white">
                                        {notification.description}
                                    </Typography>
                                    <br />
                                    <Typography component="span" variant="body2" color="white">
                                        {notification.createdOn}
                                    </Typography>
                                </>
                            }
                            primaryTypographyProps={{ color: "white", fontWeight: "bold" }}
                            secondaryTypographyProps={{ color: "white" }}
                        />
                    </ListItem>
                ))}
            </List>
        </Box>
    );
}