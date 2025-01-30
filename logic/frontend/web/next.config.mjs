/** @type {import('next').NextConfig} */
const nextConfig = {
    env: {
        API_URL: process.env.API_URL || 'https://boast.social/api',
        PUBLIC_URL: process.env.PUBLIC_URL || 'http://localhost:3000',
        AUTH0_SECRET: '7754a34db1be628721540d57dc48e51d614fdeade7e706e525d7203f7cea1556',
        AUTH0_BASE_URL: 'http://localhost:3000',
        AUTH0_ISSUER_BASE_URL: 'https://dev-hqdjfde22jocup8g.us.auth0.com',
        AUTH0_CLIENT_ID: 'IteLOrN17vUpWI4LHgkJJh6L9kg8rIzY',
        AUTH0_CLIENT_SECRET: 'sh_rFlyPffYvTAnTpItspeHU60V8p7KFegBWEeOFwl8wW362Bw9l8V_n9b3XiCL2'
    },
};

export default nextConfig;
