'use client';

import {loginUser} from "@/service/ApiService";
import {useEffect, useState} from "react";
import {useRouter} from "next/navigation";
import {Container} from "@mui/material";

export default function Page() {
    const [msg, setMsg] = useState('Verify Login ...');
    const router = useRouter();

    useEffect(() => {
        fetch('/api/auth/id-token')
            .then((response) => response.json())
            .then((data) => {
                loginUser(data.idToken)
                    .then((response) => {
                        router.push('/FYP');
                    })
                    .catch((error) => {
                        console.log(error)
                    });
            })
            .catch((error) => {
                setMsg('Verify Login Failed');
                console.log(error)
            });
    }, []);

    return (
        <Container sx={{marginTop: "5vh"}}>
            {msg}
        </Container>
    );
}
