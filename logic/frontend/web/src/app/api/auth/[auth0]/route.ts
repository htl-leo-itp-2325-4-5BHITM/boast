import {handleAuth, handleLogin} from '@auth0/nextjs-auth0';

export const GET = handleAuth({
    login(req: any, res: any) {
        return handleLogin(req, res, {
            authorizationParams: {scope: 'openid profile email'},
            returnTo: "/login-success",
        });
    },
    signup: handleLogin({ authorizationParams: { screen_hint: 'signup' } }),
});