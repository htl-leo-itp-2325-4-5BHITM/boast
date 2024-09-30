// src/app/login/page.tsx
"use client"
import { useState } from "react";
import { TextField, Button, Box, Typography } from "@mui/material";
import axios from "axios";
import { UserModel } from "@/model/model";
import {useUser} from "@/service/UserContext";

export default function Page() {
    const [name, setName] = useState("");
    const [userData, setUserData] = useState<UserModel | null>(null);
    const { setUser } = useUser();

    const handleSubmit = async (event: { preventDefault: () => void; }) => {
        event.preventDefault();
        try {
            const response = await axios.get(`https://www.boast.social/api/users/login/${name}`);
            setUserData(response.data);
            setUser({ username: response.data.username, email: response.data.email });
        } catch (error) {
            console.error("Error logging in:", error);
        }
    };

    return (
        <Box display="flex" flexDirection="column" alignItems="center" justifyContent="center" height="100vh" bgcolor="#1A1C40">
            <form onSubmit={handleSubmit}>
                <TextField
                    label="Name"
                    variant="outlined"
                    fullWidth
                    margin="normal"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    InputProps={{ style: { color: 'white' } }}
                    InputLabelProps={{ style: { color: 'white' } }}
                />
                <Button type="submit" variant="contained" color="primary">
                    Login
                </Button>
            </form>
            {userData && (
                <Box mt={4} p={2} bgcolor="#22264B" color="white" borderRadius="8px">
                    <Typography variant="h6">User Data</Typography>
                    <Typography>User ID: {userData.userId}</Typography>
                    <Typography>Created On: {new Date(userData.createdOn).toLocaleString()}</Typography>
                    <Typography>Is Public: {userData.isPublic ? "Yes" : "No"}</Typography>
                    <Typography>Name: {userData.name}</Typography>
                    <Typography>Username: {userData.username}</Typography>
                    <Typography>Email: {userData.email}</Typography>
                </Box>
            )}
        </Box>
    );
}