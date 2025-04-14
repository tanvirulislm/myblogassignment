<script setup>
const props = defineProps({
    posts: Array,
});
import { Link } from "@inertiajs/vue3";
</script>

<template>
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Recent Posts</h5>

            <!-- If posts exist -->
            <ul class="list-group" v-if="props.posts.length">
                <li
                    v-for="post in props.posts.slice(0, 5)"
                    :key="post.id"
                    class="list-group-item"
                >
                    <Link :href="`/edit-post/${post.id}`">{{
                        post.title
                    }}</Link>
                </li>
            </ul>

            <!-- If no posts -->
            <div v-else class="text-center">
                <p class="text-muted">No recent posts yet.</p>
                <a href="/create-post" class="btn btn-sm btn-primary">
                    Create New Post
                </a>
            </div>

            <!-- Show All Posts Button (Links to another page) -->
            <div v-if="props.posts.length === 5" class="text-center mt-3">
                <a href="/all-posts" class="btn btn-sm btn-secondary">
                    Show All Posts
                </a>
            </div>
        </div>
    </div>
</template>
