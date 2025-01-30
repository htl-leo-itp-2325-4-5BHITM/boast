/*"use client";
import React, {createContext, ReactNode, useContext, useEffect, useState} from 'react';
import axios from 'axios';
import {useRouter} from 'next/navigation';
import {UserModel} from '@/model/model';

interface UserProviderProps {
    children: ReactNode;
}

interface UserContextProps {
    user: UserModel | null;
    loading: boolean;
    error: string | null;
    login: (userName: string) => Promise<void>;
    logout: () => void;
}

const UserContext = createContext<UserContextProps | undefined>(undefined);

export const UserProvider = ({ children }: UserProviderProps) => {
    const [user, setUser] = useState<UserModel | null>(null);
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);
    const router = useRouter();

    useEffect(() => {
        const storedUser = localStorage.getItem('user');
        if (storedUser) {
            setUser(JSON.parse(storedUser));
            setLoading(false);
        } else {
            setLoading(false);
            router.push('/login');
        }
    }, [router]);

    const login = async (userName: string) => {
        setLoading(true);
        try {
            const response = await axios.get<UserModel>(`https://www.boast.social/api/users/login/${userName}`);
            setUser(response.data);
            localStorage.setItem('user', JSON.stringify(response.data));
            console.log(response.data)
            router.push('/FYP');
        } catch {
            setError('Failed to fetch user data');
        } finally {
            setLoading(false);
        }
    };

    const logout = () => {
        console.log("logout")
        setUser(null);
        localStorage.removeItem('user');
        router.push('/login');
    };

    return (
        <UserContext.Provider value={{ user, loading, error, login, logout }}>
            {children}
        </UserContext.Provider>
    );
};

export const useUser = (): UserContextProps => {
    const context = useContext(UserContext);
    if (context === undefined) {
        throw new Error('useUser must be used within a UserProvider');
    }
    return context;
};*/