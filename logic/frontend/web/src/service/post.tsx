import axios from 'axios';
import {PostModel} from "@/model/model";

export async function getPosts(): Promise<number[]> {
    try {
        const response = await axios.get('https://www.boast.social/api/posts');
        return response.data;
    } catch (error) {
        console.error('Error fetching posts:', error);
        throw error;
    }
}

export async function getPost(postId: number): Promise<PostModel> {
    try {
        const response = await axios.get(`https://www.boast.social/api/posts/${postId}`);
        return response.data;
    } catch (error) {
        console.error('Error fetching post:', error);
        throw error;
    }
}