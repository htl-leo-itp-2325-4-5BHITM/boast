export interface AuthUser {
    jwt: string;
    userId: number;
    isPublic: boolean;
    name: string;
    username: string;
    email: string;
}

export interface PostModel {
    postId: number;
    creatorName: string;
    status: string;
    createdOn: string;
    creatorId: number;
    title: string;
    definition: string;
    type: string;
    postDetails: Array<PostDetailModel>;
    typeInfo: {
        pollAnswers: Array<PollAnswer>;
    };
    winnerPoll: number;
}

export interface PostDetailModel {
    createdOn: Date,
    creatorId: number,
    creatorName: string,
    postDetailsId: number,
    postId: number,
    text: string,
    poll_answerId: number;
}

export interface PostDetailDTO {
    postDetailsId: number,
    createdOn: Date,
    creatorId: number,
    creatorName: string,
    postId: number,
    text: string
}

export interface PollAnswer {
    poll_answerId: number,
    title: string;
}


export interface UserModel {
    userId: number,
    createdOn: string,
    isPublic: boolean,
    name: string,
    username: string,
    email: string,
    relationStatus: string,
    posts: Array<number>
}

export interface ProfileModel {
    userId: number,
    createdOn: string,
    name: string,
    username: string,
    follower: string,
    following: string,
    relationStatus: string,
    posts: Array<number>
}

export interface PollOption {
    id: number,
    title: string
}

export interface MilestoneData {
    title: string;
    description: string;
    isCompleted: boolean;
}