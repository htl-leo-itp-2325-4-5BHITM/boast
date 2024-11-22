"use client";
import React, {useEffect, useState} from 'react';
import {AppBar, Autocomplete, Box, TextField, Toolbar, Typography} from "@mui/material";
import Image from "next/image";
import AccountCircle from '@mui/icons-material/AccountCircle';
import { useUser } from '@/provider/UserProvider';
import axios from "axios";
import {UserModel} from "@/model/model";
import Link from "next/link";

const HeaderComponent = () => {
    const { user } = useUser();
    const [searchTerm, setSearchTerm] = useState('');
    const [options, setOptions] = useState<UserModel[]>([]);

    const fetchUsers = async () => {
        if (searchTerm.length > 1) {
            try {
                const response = await axios.get(`https://www.boast.social/api/users/search/${searchTerm}`, {
                    headers: {
                        'accept': '*/*',
                        'reqUserId': user?.userId || '100',
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

    useEffect(() => {
        fetchUsers();
    }, [searchTerm]);


    return (
        <AppBar position="fixed" sx={{ bgcolor: "#1C2357", zIndex: "100" }}>
            <Toolbar sx={{ mx: 3 }} disableGutters>
                <Image src={"/boast_white.png"} alt={"boast"} width={120} height={10}
                       priority={true} style={{objectFit: "contain", width: "auto", height: "auto"}}/>
                <Autocomplete
                    sx={{
                        width: 300,
                        ml: 4,
                        '& .MuiInputBase-root': {
                            color: '#fff',
                        },
                        '& .MuiInputLabel-root': {
                            color: '#fff',
                        },
                        '& .MuiAutocomplete-popupIndicator': {
                            color: '#fff',
                        },
                        '& .MuiAutocomplete-clearIndicator': {
                            color: '#fff',
                        },
                    }}
                    freeSolo
                    options={options}
                    getOptionLabel={(option: UserModel | string ) => (typeof option === "string") ? option : option.username}
                    renderOption={(props, option) => (
                        <Link onClick={() => {
                            setSearchTerm('')
                        }} href={`/profile/${option.username}`} passHref>
                            <Box component="li" {...props}>
                                {option.username}
                            </Box>
                        </Link>
                    )}
                    renderInput={(params) => (
                        <TextField
                            {...params}
                            InputLabelProps={{
                                style: {color: '#fff'},
                            }}
                            label="Search Users"
                            variant="outlined"
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    )}
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