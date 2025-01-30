import {getSession} from "@auth0/nextjs-auth0";
import {NextResponse} from "next/server";

export async function GET(request: any) {
    try {
        //@ts-ignore
        const session = await getSession(request);
        if (session) {
            const idToken = session.idToken;
            return NextResponse.json({
                idToken
            }, {
                status: 200,
            } as any)
        } else {
            return NextResponse.json({
                message: "Not authenticated"
            }, {
                status: 401,
            } as any)
        }
    } catch (error) {
        console.error(error);
        return NextResponse.json({
            message: "Error getting ID token"
        }, {
            status: 500,
        } as any)
    }
}