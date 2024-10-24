"use client";
import { useState } from "react";
import { Box, Button, TextField, Typography, ToggleButton, ToggleButtonGroup, Dialog, DialogTitle, DialogContent, IconButton } from "@mui/material";
import AddIcon from '@mui/icons-material/Add';
import DeleteIcon from '@mui/icons-material/Delete';
import axios from "axios";
import { useUser } from "@/provider/UserProvider";

interface CreateComponentProps {
    fetchPosts: () => void;
}

export default function CreateComponent({ fetchPosts }: CreateComponentProps) {
    const [title, setTitle] = useState("");
    const [description, setDescription] = useState("");
    const [betType, setBetType] = useState("TEXT");
    const [pollOptions, setPollOptions] = useState([{ id: 1, title: "" }, { id: 2, title: "" }]);
    const [pollDialogOpen, setPollDialogOpen] = useState(false);
    const { user } = useUser();

    const resetForm = () => {
        setTitle("");
        setDescription("");
        setBetType("TEXT");
        setPollOptions([{ id: 1, title: "" }, { id: 2, title: "" }]);
    };

    const handleCreate = async () => {
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
        <Box p={3} bgcolor="#22264B" color="white" borderRadius="8px">
            <Typography>Bet</Typography>
            <TextField
                label=""
                placeholder=""
                variant="outlined"
                fullWidth
                margin="normal"
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
            <Typography>Description</Typography>
            <TextField
                label=""
                variant="outlined"
                fullWidth
                margin="normal"
                multiline
                rows={4}
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
            <ToggleButtonGroup
                value={betType}
                exclusive
                onChange={(e, newType) => {
                    setBetType(newType);
                    if (newType === "POLL") {
                        setPollDialogOpen(true);
                    }
                }}
                aria-label="bet type"
                sx={{
                    mt: 2,
                    mb: 2,
                    display: "flex",
                    justifyContent: "center",
                    '& .MuiToggleButton-root': {
                        color: 'white', // Text color
                        borderColor: 'white', // Border color
                        minWidth: '150px', // Make buttons wider
                        '&.Mui-selected': {
                            backgroundColor: '#3f51b5', // Background color when selected
                            color: 'white', // Text color when selected
                        },
                        '&:hover': {
                            backgroundColor: '#3f51b5', // Background color on hover
                            color: 'white', // Text color on hover
                        },
                    },
                }}
            >
                <ToggleButton value="TEXT" aria-label="text bet">
                    Text
                </ToggleButton>
                <ToggleButton value="POLL" aria-label="poll bet">
                    Poll
                </ToggleButton>
            </ToggleButtonGroup>
            <Box display="flex" justifyContent="flex-end">
                <Button variant="contained" color="primary" onClick={handleCreate}>
                    Create
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
    );
}