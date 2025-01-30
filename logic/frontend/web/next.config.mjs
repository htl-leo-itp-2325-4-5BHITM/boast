/** @type {import('next').NextConfig} */
const nextConfig = {
    env: {
        API_URL: process.env.API_URL || 'https://boast.social',
        PUBLIC_URL: process.env.PUBLIC_URL || 'http://localhost:3000',
    },
};

export default nextConfig;
