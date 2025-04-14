<script setup>
import Navbar from "@/Components/Navbar.vue";
import { Link, usePage } from "@inertiajs/vue3";
import axios from "axios";
import { onMounted, ref } from "vue";

const props = defineProps({ post: Object });

const authUser = usePage().props.auth.user;

const likeCount = ref(0);
const liked = ref(false);
const comments = ref([]);
const commentText = ref("");
const replyingTo = ref(null);
const editingComment = ref(null);
const editContent = ref("");

const fetchLikeStatus = async () => {
    if (!authUser) return;
    const res = await axios.post(
        "/check-like",
        { post_id: props.post.id },
        {
            headers: { id: authUser?.id },
        }
    );
    liked.value = res.data.liked;
};

const fetchLikeCount = async () => {
    const res = await axios.get(`/like-count/${props.post.id}`);
    likeCount.value = res.data.like_count;
};

const toggleLike = async () => {
    if (!authUser) return (window.location.href = "/login");

    const res = await axios.post(
        "/toggle-like",
        { post_id: props.post.id },
        {
            headers: { id: authUser.id },
        }
    );

    liked.value = !liked.value;
    likeCount.value = res.data.like_count;
};

const fetchComments = async () => {
    const res = await axios.post(`/posts/${props.post.id}/comment-list`);
    comments.value = res.data;
};

const postComment = async () => {
    if (!authUser) return (window.location.href = "/login");

    await axios.post(
        `/posts/${props.post.id}/comments`,
        {
            content: commentText.value,
            parent_id: replyingTo.value,
        },
        {
            headers: { id: authUser.id },
        }
    );

    commentText.value = "";
    replyingTo.value = null;
    fetchComments();
};

const deleteComment = async (id) => {
    await axios.post(
        `/comments/${id}`,
        {},
        {
            headers: { id: authUser.id },
        }
    );
    fetchComments();
};

const updateComment = async (id) => {
    await axios.post(
        `/comment/${id}`,
        {
            content: editContent.value,
        },
        {
            headers: { id: authUser.id },
        }
    );

    editingComment.value = null;
    editContent.value = "";
    fetchComments();
};

onMounted(() => {
    fetchLikeCount();
    fetchComments();
    if (authUser) fetchLikeStatus();
});
</script>

<template>
    <Navbar />
    <!-- adding back button -->
    <div class="container mt-5">
        <Link href="/public-posts" class="btn btn-outline-secondary mb-3">
            <i class="fas fa-arrow-left"></i> Back to Posts
        </Link>
    </div>
    <div class="container mt-5">
        <!-- Post -->
        <div class="card mb-4 shadow">
            <div class="card-body">
                <!-- Hrere I want to show post Tags -->
                <div class="mb-2">
                    <span
                        v-for="tag in post.tags"
                        :key="tag.id"
                        class="badge bg-secondary me-1"
                    >
                        {{ tag.name }}
                    </span>
                </div>
                <!-- post thumbnail -->
                <img
                    v-if="post.image"
                    :src="`/${post.image}`"
                    class="card-img-top mb-3 height-200 width-auto"
                    alt="Post Thumbnail"
                />
                <h2 class="card-title">{{ post.title }}</h2>
                <div v-html="post.content" class="card-text"></div>
            </div>
        </div>

        <!-- Like -->
        <div class="mb-3">
            <button class="btn btn-outline-primary me-2" @click="toggleLike">
                <i :class="liked ? 'fas fa-thumbs-up' : 'far fa-thumbs-up'"></i>
                {{ liked ? "Liked" : "Like" }}
            </button>
            <span>{{ likeCount }} likes</span>
        </div>

        <!-- Comment Input -->
        <div class="card mb-4 shadow">
            <div class="card-body">
                <h5 class="card-title">Leave a Comment</h5>
                <textarea
                    class="form-control mb-2"
                    v-model="commentText"
                    rows="3"
                    placeholder="Write something..."
                ></textarea>
                <div class="d-flex justify-content-between align-items-center">
                    <div v-if="replyingTo" class="text-muted small">
                        Replying to comment #{{ replyingTo }}
                        <a
                            href="#"
                            @click.prevent="replyingTo = null"
                            class="ms-2 text-danger"
                            >Cancel</a
                        >
                    </div>
                    <button class="btn btn-success" @click="postComment">
                        <i class="fas fa-paper-plane me-1"></i> Post
                    </button>
                </div>
            </div>
        </div>

        <!-- Comments -->
        <div
            v-for="comment in comments"
            :key="comment.id"
            class="card mb-3 shadow-sm"
        >
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <strong>{{ comment.user?.name }}</strong>
                    <div>
                        <button
                            class="btn btn-sm btn-outline-secondary me-1"
                            @click="replyingTo = comment.id"
                        >
                            <i class="fas fa-reply"></i>
                        </button>
                        <button
                            v-if="authUser?.id === comment.user_id"
                            class="btn btn-sm btn-outline-warning me-1"
                            @click="
                                () => {
                                    editingComment = comment.id;
                                    editContent = comment.content;
                                }
                            "
                        >
                            <i class="fas fa-edit"></i>
                        </button>
                        <button
                            v-if="authUser?.id === comment.user_id"
                            class="btn btn-sm btn-outline-danger"
                            @click="deleteComment(comment.id)"
                        >
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </div>
                </div>

                <div v-if="editingComment === comment.id" class="mt-2">
                    <input v-model="editContent" class="form-control mb-2" />
                    <div class="d-flex justify-content-end gap-2">
                        <button
                            class="btn btn-sm btn-success"
                            @click="updateComment(comment.id)"
                        >
                            Save
                        </button>
                        <button
                            class="btn btn-sm btn-secondary"
                            @click="editingComment = null"
                        >
                            Cancel
                        </button>
                    </div>
                </div>
                <div v-else class="mt-2">
                    {{ comment.content }}
                </div>

                <!-- Replies -->
                <div
                    v-if="comment.replies && comment.replies.length"
                    class="mt-3 ms-4 border-start ps-3"
                >
                    <div
                        v-for="reply in comment.replies"
                        :key="reply.id"
                        class="mb-2 small text-muted"
                    >
                        <strong>{{ reply.user?.name }}</strong
                        >: {{ reply.content }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
