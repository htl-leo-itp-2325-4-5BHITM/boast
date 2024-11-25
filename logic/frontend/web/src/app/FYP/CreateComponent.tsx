import { useState, useRef, useEffect } from "react";
import { Box, Button, TextField, Typography, Dialog, DialogTitle, DialogContent, IconButton } from "@mui/material";
import AddIcon from '@mui/icons-material/Add';
import DeleteIcon from '@mui/icons-material/Delete';
import axios from "axios";
import { useUser } from "@/provider/UserProvider";
import { DatePicker, LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import dayjs from "dayjs";
import Confetti from "react-confetti";

interface CreateComponentProps {
    fetchPosts: () => void;
}

export default function CreateComponent({ fetchPosts }: CreateComponentProps) {
    const [title, setTitle] = useState("");
    const [description, setDescription] = useState("");
    const [pollOptions, setPollOptions] = useState([{ id: 1, title: "" }, { id: 2, title: "" }]);
    const [pollDialogOpen, setPollDialogOpen] = useState(false);
    const { user } = useUser();
    const [betType, setBetType] = useState<string | null>("text");
    const [showConfetti, setShowConfetti] = useState(false);
    const [showThankYou, setShowThankYou] = useState(false);
    const boxRef = useRef<HTMLDivElement>(null);
    const [boxDimensions, setBoxDimensions] = useState({ width: 0, height: 0 });

    useEffect(() => {
        if (boxRef.current) {
            setBoxDimensions({
                width: boxRef.current.offsetWidth,
                height: boxRef.current.offsetHeight,
            });
        }
    }, [showConfetti]);

    const toggleBetType = (type: string) => () => {
        setBetType(type);
        if (type === "POLL") {
            setPollDialogOpen(true);
        }
    }

    const resetForm = () => {
        setTitle("");
        setDescription("");
        setPollOptions([{ id: 1, title: "" }, { id: 2, title: "" }]);
    };

    const handleCreate = async () => {
        console.log("Creating bet...");
        console.log(betType)
        const newBet = {
            createdOn: new Date().toISOString(),
            title,
            definition: description,
            creatorId: user?.userId,
            creatorName: user?.username,
            status: "OPEN",
            type: betType,
            typeInfo: betType === "POLL" ? { pollAnswers: pollOptions.map(option => ({ title: option.title })) } : undefined,
        };
        console.log(newBet);

        try {
            const url = betType === "POLL" ? "https://www.boast.social/api/posts/poll" : "https://www.boast.social/api/posts/text";
            await axios.post(url, newBet);
            console.log("Bet created successfully:", newBet);
            resetForm(); // Clear the form after successful creation
            fetchPosts(); // Fetch the latest posts
            setShowConfetti(true);
            setShowThankYou(true);
            setTimeout(() => {
                setShowConfetti(false);
                setShowThankYou(false);
            }, 7500);
        } catch (error) {
            console.error("Error creating bet:", error);
        }
    };

    const handlePollOptionChange = (id: number, value: string) => {
        setPollOptions(pollOptions.map(option => option.id === id ? { ...option, title: value } : option));
    };

    const addPollOption = () => {
        setPollOptions([...pollOptions, { id: pollOptions.length + 1, title: "" }]);
    };

    const removePollOption = (id: number) => {
        if (pollOptions.length > 2) {
            setPollOptions(pollOptions.filter(option => option.id !== id));
        }
    };

    return (
        <Box ref={boxRef} p={3} bgcolor="#22264B" color="white" borderRadius="8px" sx={{ height: "50vh", width: "22vw", position: "relative"}}>
            {showConfetti && <Confetti width={boxDimensions.width} height={boxDimensions.height} style={{ position: "absolute", top: 0, left: 0 }} />}
            {showThankYou ? (
                <Box p={2} borderRadius="8px" sx={{ height: "100%", width: "100%", display: "flex", alignItems: "center", justifyContent: "center" }}>
                    <Typography variant="h4" fontWeight={"bold"} color="white" textAlign="center">Thank you for creating a bet!</Typography>
                </Box>
            ) : (
                <Box>
                    <Box mb={1}>
                        <Typography fontWeight="bold">Bet</Typography>
                        <TextField
                            label=""
                            placeholder=""
                            variant="outlined"
                            fullWidth
                            value={title}
                            onChange={(e) => setTitle(e.target.value)}
                            sx={{
                                '& .MuiInputBase-input': {
                                    color: 'white',
                                },
                                '& .MuiInputLabel-root': {
                                    color: 'white',
                                },
                            }}
                        />
                    </Box>
                    <Box my={1}>
                        <Typography fontWeight="bold">Description</Typography>
                        <TextField
                            label=""
                            variant="outlined"
                            fullWidth
                            value={description}
                            onChange={(e) => setDescription(e.target.value)}
                            sx={{
                                '& .MuiInputBase-input': {
                                    color: 'white',
                                },
                                '& .MuiInputLabel-root': {
                                    color: 'white',
                                },
                            }}
                        />
                    </Box>

                    <Box my={1}>
                        <Typography fontWeight="bold">End date</Typography>
                        <LocalizationProvider dateAdapter={AdapterDayjs}>
                            <DatePicker
                                defaultValue={dayjs(Date.now() + 7 * 24 * 60 * 60 * 1000)} // 7 days from now
                                sx={{ width: "100%", '& input': { color: 'white' }, my: "auto", svg: { color: 'white' } }}
                            />
                        </LocalizationProvider>
                    </Box>

                    <Box my={1}>
                        <Typography fontWeight="bold">Options</Typography>
                        <Box sx={{ display: "flex", justifyContent: "space-between" }}>
                            <Button sx={{ py: 1.5, width: "40%", bgcolor: betType === "text" ? "#3656FF" : "#39426D" }} variant="contained" onClick={toggleBetType("text")}>
                                <Typography fontWeight="bold">
                                    Text
                                </Typography>
                            </Button>
                            <Button sx={{ py: 1.5, width: "40%", bgcolor: betType === "POLL" ? "#3656FF" : "#39426D" }} variant="contained" onClick={toggleBetType("POLL")}>
                                <Typography fontWeight="bold">
                                    Stats
                                </Typography>
                            </Button>
                        </Box>
                    </Box>

                    <Box mt={2}>
                        <Button sx={{ py: 1.5, bgcolor: "#3656FF" }} variant="contained" fullWidth disabled={title === "" || description === ""} onClick={handleCreate}>
                            <Typography fontWeight="bold">
                                Create
                            </Typography>
                        </Button>
                    </Box>

                    <Dialog open={pollDialogOpen} onClose={() => setPollDialogOpen(false)} maxWidth="sm" fullWidth>
                        <DialogTitle>Customize Poll Options</DialogTitle>
                        <DialogContent>
                            {pollOptions.map(option => (
                                <Box key={option.id} display="flex" alignItems="center" mb={2}>
                                    <TextField
                                        label={`Option ${option.id}`}
                                        variant="outlined"
                                        fullWidth
                                        value={option.title}
                                        onChange={(e) => handlePollOptionChange(option.id, e.target.value)}
                                    />
                                    <IconButton onClick={() => removePollOption(option.id)} color="secondary">
                                        <DeleteIcon />
                                    </IconButton>
                                </Box>
                            ))}
                            <Button startIcon={<AddIcon />} onClick={addPollOption} color="primary">
                                Add Option
                            </Button>
                            <Box display="flex" justifyContent="flex-end" mt={2}>
                                <Button variant="contained" color="primary" onClick={() => setPollDialogOpen(false)}>
                                    Confirm
                                </Button>
                            </Box>
                        </DialogContent>
                    </Dialog>
                </Box>
            )}
        </Box>
    );
}