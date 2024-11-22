"use client"
import React, {useEffect, useState} from "react";
import axios from "axios";
import {useUser} from "@/provider/UserProvider";
import {Box, List, ListItem, Typography} from "@mui/material";

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
    const {user} = useUser();
    const [notifications, setNotifications] = useState<Notification[]>([]);

    const colors = ["#3656FF", "#C20B4E", "#4ECA31"]

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
        <Box color={"white"} margin={5} mt={12} borderRadius={2} position={"absolute"}
             sx={{bgcolor: "#22264B", zIndex: "100"}}>
            <Typography variant="h4" margin={3}>{notifications.length} Notifications</Typography>
            <Box overflow={"auto"} sx={{bgcolor: "#22264B", width: "78vw", height: "75vh"}} p={3}>

                <List>
                    {notifications.length === 0 && (
                        <Typography component="span" color="grey">
                            No notifications yet
                        </Typography>
                    )
                    }

                    {notifications.map((notification, index) => (
                        <ListItem key={notification.id} sx={{
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
                                <Typography fontWeight={"bold"}>{notification.description.split(":")[0]}</Typography>
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
        </Box>
    );
}