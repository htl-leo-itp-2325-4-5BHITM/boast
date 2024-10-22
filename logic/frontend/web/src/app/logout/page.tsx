"use client"

import {useUser} from "@/provider/UserProvider";
import {useEffect} from "react";

export default function Page() {
    const {logout} = useUser();

    useEffect(() => {
        logout();
    }, []);

    return (
        <></>
    );
}