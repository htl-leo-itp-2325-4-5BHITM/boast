"use client";
import React, {useEffect, useState} from 'react';
import {AppBar, Autocomplete, Box, TextField, Toolbar, Typography} from "@mui/material";
import AccountCircle from '@mui/icons-material/AccountCircle';
import { useUser } from '@/provider/UserProvider';
import axios from "axios";
import {UserModel} from "@/model/model";
import Link from "next/link";

const HeaderComponent = () => {
    const { user } = useUser();
    const [searchTerm, setSearchTerm] = useState('');
    const [options, setOptions] = useState<UserModel[]>([]);

    useEffect(() => {
        const fetchUsers = async () => {
            if (searchTerm.length > 2) {
                try {
                    const response = await axios.get(`https://www.boast.social/api/users/search/${searchTerm}`, {
                        headers: {
                            'accept': '*/*',
                            'reqUserId': '100'
                        }
                    });
                    setOptions(response.data);
                } catch (error) {
                    console.error('Error fetching users:', error);
                }
            } else {
                setOptions([]);
            }
        };

        fetchUsers();
    }, [searchTerm]);


    return (
        <AppBar position="static" sx={{ bgcolor: "#1C2357" }}>
            <Toolbar sx={{ mx: 3 }} disableGutters>
                <Typography variant="h6" component="div">
                    boast
                </Typography>


                <Autocomplete
                    freeSolo
                    options={options}
                    getOptionLabel={(option) => option.username}
                    renderOption={(props, option) => (
                        <Link href={`/profile/${option.username}`} passHref>
                            <Box component="li" {...props}>
                                {option.username}
                            </Box>
                        </Link>
                    )}
                    renderInput={(params) => (
                        <TextField
                            {...params}
                            label="Search Users"
                            variant="outlined"
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    )}
                    sx={{ width: 300, mx: 2}}
                />

                <Box sx={{flexGrow: 1}}></Box>

                <Box sx={{ display: "flex", flexDirection: "row" }}>
                    <AccountCircle sx={{ fontSize: 50, my: "auto", mx: 1 }} />
                    <Box>
                        <Typography variant="h6" component="div">
                            {user?.username || 'Guest'}
                        </Typography>
                        <Typography variant="h6" component="div">
                            {user?.email || 'guest@example.com'}
                        </Typography>
                    </Box>
                </Box>
            </Toolbar>
        </AppBar>
    );
};

export default HeaderComponent;