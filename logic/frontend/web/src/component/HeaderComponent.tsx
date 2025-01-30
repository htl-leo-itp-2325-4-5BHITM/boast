"use client";
import React, {useEffect, useState} from 'react';
import {AppBar, Autocomplete, Box, TextField, Toolbar, Typography, useMediaQuery} from "@mui/material";
import Image from "next/image";
import {UserModel} from "@/model/model";
import Link from "next/link";
import HeaderAuth from "@/component/HeaderAuth";
import {getData} from "@/service/ApiService";

const HeaderComponent = () => {
    const [searchTerm, setSearchTerm] = useState('');
    const [options, setOptions] = useState<UserModel[]>([]);
    const isMobile = useMediaQuery('(max-width: 991px)'); // Detects small screens

    const fetchUsers = async () => {
        if (searchTerm.length > 1) {
            try {
                const response = await getData<UserModel[]>(`/users/search/${searchTerm}`);
                setOptions(response);
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
        <AppBar position="fixed" sx={{bgcolor: "#1C2357", zIndex: "100"}}>
            <Toolbar sx={{mx: 3, justifyContent: isMobile ? "space-between" : ""}} disableGutters>
                {/* Logo */}
                <Image src={"/boast_white.png"} alt={"boast"} width={120} height={10}
                       priority={true} style={{objectFit: "contain", width: "auto", height: "auto"}}/>

                {/* Search Bar */}
                <Autocomplete
                    sx={{
                        width: 300,
                        ml: 4,
                        '& .MuiInputBase-root': {color: '#fff', height: '40px'},
                        '& .MuiInputLabel-root': {color: '#fff'},
                        '& .MuiAutocomplete-popupIndicator': {color: '#fff'},
                        '& .MuiAutocomplete-clearIndicator': {color: '#fff'},
                    }}
                    freeSolo
                    options={options}
                    getOptionLabel={(option: UserModel | string) => (typeof option === "string") ? option : option.username}
                    renderOption={(props, option) => (
                        <Link key={option.userId} onClick={() => setSearchTerm('')} href={`/profile/${option.username}`} passHref>
                            <Box component="li" {...props}>
                                {option.username}
                            </Box>
                        </Link>
                    )}
                    renderInput={(params) => (
                        <TextField
                            {...params}
                            InputLabelProps={{style: {color: '#fff'}}}
                            label="Search Users"
                            variant="outlined"
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    )}
                />

                {!isMobile && (
                    <>
                        <HeaderAuth />
                    </>
                )}
            </Toolbar>
        </AppBar>
    );
};

export default HeaderComponent;
