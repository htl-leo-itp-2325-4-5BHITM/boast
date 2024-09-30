import {Divider, Drawer, Typography} from "@mui/material";
import Link from "next/link";



export default function SideBarComponent() {
    return (
        <Drawer
            sx={{
                width: "calc((100vw/12)*2)",
                flexShrink: 0,
                '& .MuiDrawer-paper': {
                    width: "calc((100vw/12)*2)",
                    boxSizing: 'border-box',
                },
            }}
            variant="permanent"
            anchor="bottom"
            PaperProps={{sx: {width: "calc((100vw/12)*2)", bgcolor: "#1C2357", height: "calc(100vh - 64px)"}}}
        >
            <Divider/>
            <Link href="/FYP" ><Typography fontFamily="Roboto" >
                For You
            </Typography></Link>
            <Link href="/" ><Typography >
                Profile
            </Typography></Link>
            <Link href="/" ><Typography >
                Settings
            </Typography></Link>
            <Link href="/" ><Typography >
                Logout
            </Typography></Link>

        </Drawer>
    );
}

