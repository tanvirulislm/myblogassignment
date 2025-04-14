<script setup>
import { Link } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";
import axios from "axios";
import { ref } from "vue";

const props = defineProps({
    recentBookmarks: Array,
});

const toaster = createToaster({ position: "top-right" });
const bookmarks = ref(props.recentBookmarks || []);

const removeBookmark = async (bookmarkId, postId) => {
    try {
        const response = await axios.post(
            "/toggle-bookmark",
            { post_id: postId },
            {
                headers: {
                    "X-CSRF-TOKEN": document.querySelector(
                        'meta[name="csrf-token"]'
                    ).content,
                    Accept: "application/json",
                    "Content-Type": "application/json",
                },
            }
        );

        if (response.data.status === "success") {
            bookmarks.value = bookmarks.value.filter(
                (b) => b.id !== bookmarkId
            );
            toaster.success("Bookmark removed successfully");
        } else {
            toaster.error(response.data.message || "Failed to remove bookmark");
        }
    } catch (error) {
        console.error("Error removing bookmark:", error);
        const errorMessage =
            error.response?.data?.message || "Failed to remove bookmark";
        toaster.error(errorMessage);
    }
};
</script>

<template>
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <h5 class="card-title">Recent Bookmarks</h5>

            <ul class="list-group list-group-flush" v-if="bookmarks.length">
                <li
                    v-for="bookmark in bookmarks"
                    :key="bookmark.id"
                    class="list-group-item d-flex justify-content-between align-items-center"
                >
                    <Link
                        :href="`/public-posts/${bookmark.post?.id}`"
                        class="text-decoration-none flex-grow-1"
                    >
                        {{ bookmark.post?.title || "Post not found" }}
                    </Link>

                    <div class="d-flex align-items-center">
                        <small class="text-muted me-3">
                            {{
                                new Date(
                                    bookmark.created_at
                                ).toLocaleDateString()
                            }}
                        </small>
                        <button
                            @click="
                                removeBookmark(bookmark.id, bookmark.post.id)
                            "
                            class="btn btn-sm btn-outline-danger"
                            title="Remove bookmark"
                        >
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </li>
            </ul>

            <div v-else class="text-center py-3">
                <p class="text-muted mb-1">No recent bookmarks yet.</p>
                <Link
                    href="/public-posts"
                    class="btn btn-sm btn-outline-primary"
                >
                    Browse Posts
                </Link>
            </div>
        </div>
    </div>
</template>

<style scoped>
.list-group-item {
    transition: background-color 0.2s;
}

.list-group-item:hover {
    background-color: #f8f9fa;
}

.list-group-item a:hover {
    text-decoration: underline;
}

.btn-outline-danger {
    padding: 0.25rem 0.5rem;
}

.btn-outline-danger:hover {
    background-color: #dc3545;
    color: white;
}
</style>
