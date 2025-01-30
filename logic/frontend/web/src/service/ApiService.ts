import axios, {AxiosInstance, AxiosRequestConfig, AxiosResponse, CreateAxiosDefaults} from 'axios';
import {AuthUser} from "@/model/model";
import {jwtDecode, JwtPayload} from "jwt-decode";

const LOCAL_STORAGE_KEY = "boast.social";

const api: AxiosInstance = axios.create({
    baseURL: process.env.API_URL,
    headers: {
        'Content-Type': 'application/json',
    },
} as CreateAxiosDefaults);

export let loadedAuthUser: AuthUser = {
} as AuthUser;

export const checkAuth = (): AuthUser | null => {
    try {
        const data = localStorage.getItem(LOCAL_STORAGE_KEY);
        if (data) {
            const authUser: AuthUser = JSON.parse(data);
            const decodedToken: JwtPayload = jwtDecode(authUser.jwt);
            const currentTime = Date.now() / 1000;
            if (decodedToken && decodedToken.exp !== undefined && decodedToken.exp < currentTime) {
                clearLocalStorage();
                return null;
            }
            loadedAuthUser = authUser;
            return authUser;
        }
    } catch (error) {
        console.log(error);
    }
    return null;
}

export const clearLocalStorage = (): void => {
    localStorage.removeItem(LOCAL_STORAGE_KEY);
}

api.interceptors.request.use(
    (config) => {
        const data = localStorage.getItem(LOCAL_STORAGE_KEY);
        const authUser: AuthUser = JSON.parse(data || '{}');
        if (data) {
            config.headers['Authorization'] = `${authUser.jwt}`;
            config.headers['reqUserId'] = `${authUser.userId}`;
        }
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

export const loginUser = async (idToken: string) => {
    try {
        if (idToken === "") idToken = "abc"
        console.log("loginUser idToken", idToken);
        const response: AxiosResponse = await api.get(`/auth/${idToken}`);
        console.log("loginUser response", response);
        const authUser: AuthUser = response.data;
        localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(authUser));
        loadedAuthUser = authUser;
        return response.data;
    } catch (error) {
        console.error('API GET Error:', error);
        throw error;
    }
}

export const getData = async <T>(endpoint: string): Promise<T> => {
    try {
        const response: AxiosResponse<T> = await api.get(endpoint);
        return response.data;
    } catch (error) {
        console.error('API GET Error:', error);
        throw error;
    }
};

export const postData = async <T>(endpoint: string, data: any): Promise<T> => {
    try {
        const response: AxiosResponse<T> = await api.post(endpoint, data);
        return response.data;
    } catch (error) {
        console.error('API POST Error:', error);
        throw error;
    }
};

export const putData = async <T>(endpoint: string, data: any): Promise<T> => {
    try {
        const response: AxiosResponse<T> = await api.put(endpoint, data);
        return response.data;
    } catch (error) {
        console.error('API PUT Error:', error);
        throw error;
    }
};

export const deleteData = async <T>(endpoint: string, data: any): Promise<T> => {
    try {
        const response: AxiosResponse<T> = await api.delete(endpoint, {data: data} as AxiosRequestConfig);
        return response.data;
    } catch (error) {
        console.error('API DELETE Error:', error);
        throw error;
    }
};

export default api;