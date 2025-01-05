// src/app/login/page.tsx
"use client"
import { useState } from "react";
import { TextField, Button, Box, Typography } from "@mui/material";
import { useUser } from '@/provider/UserProvider';

export default function Page() {
    const [name, setName] = useState("");
    const { login, loading, error } = useUser();

    const handleSubmit = async (event: { preventDefault: () => void; }) => {
        event.preventDefault();
        await login(name);
    };

    return (
        <Box display="flex" flexDirection="column" alignItems="center" justifyContent="center" height="100vh" width="100%" bgcolor="#1A1C40">
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
                <Button type="submit" variant="contained" color="primary" disabled={loading}>
                    {loading ? 'Logging in...' : 'Login'}
                </Button>
            </form>
            {error && (
                <Typography color="error" mt={2}>
                    {error}
                </Typography>
            )}
        </Box>
    );
}