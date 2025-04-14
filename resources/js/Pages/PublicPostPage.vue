<script setup>
import Navbar from "@/Components/Navbar.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";
import axios from "axios";
import { computed, onMounted, ref, watch } from "vue";

const props = defineProps({
    posts: Object, // Contains { data: [], links: [], ... }
});

const toaster = createToaster({ position: "top-right" });
const page = usePage();
// Get authenticated user safely
const authUser = computed(() => page.props.auth?.user ?? null);

// --- Bookmark State ---
// Use a ref object to store bookmark status, keyed by post ID
const bookmarkedStatus = ref({});

// Initialize bookmark status from props when component mounts or props change
const initializeBookmarkStatus = () => {
    const initialStatus = {};
    if (props.posts && props.posts.data) {
        props.posts.data.forEach((post) => {
            // Use the 'is_bookmarked' flag passed from the controller
            initialStatus[post.id] = post.is_bookmarked ?? false;
        });
    }
    bookmarkedStatus.value = initialStatus;
    // console.log("Initialized/Updated Bookmark Status:", bookmarkedStatus.value); // Debugging
};

// Initialize on mount
onMounted(() => {
    initializeBookmarkStatus();
});

watch(() => props.posts.data, initializeBookmarkStatus, { deep: true });

// --- Bookmark Handler ---
const toggleBookmarkHandler = async (postId) => {
    // 1. Check if user is logged in
    if (!authUser.value) {
        toaster.warning("Please login to bookmark posts.");
        return;
    }

    // 2. Get current status and perform optimistic update
    const currentStatus = bookmarkedStatus.value[postId] ?? false;
    bookmarkedStatus.value[postId] = !currentStatus;

    try {
        // 3. Make API call
        const response = await axios.post(
            "/toggle-bookmark",
            { post_id: postId },
            {
                headers: {
                    "X-CSRF-TOKEN": page.props.csrf_token,
                },
            }
        );

        // 4. Handle response
        if (response.data.status === "success") {
            console.log("Bookmark status updated:", response.data.message);
        } else {
            // Revert optimistic update on failure reported by backend
            bookmarkedStatus.value[postId] = currentStatus;
            toaster.error(
                response.data.message || "Failed to update bookmark."
            );
        }
    } catch (error) {
        // 5. Handle network/server errors
        console.error("Bookmark toggle error:", error);
        // Revert optimistic update on actual error
        bookmarkedStatus.value[postId] = currentStatus;
        toaster.error("An error occurred while updating the bookmark.");
    }
};

// Helper function to strip HTML for preview
const stripHtml = (html) => {
    if (!html) return "";
    let doc = new DOMParser().parseFromString(html, "text/html");
    return doc.body.textContent || "";
};
</script>

<template>
    <Navbar />
    <!-- Include Navbar at the top -->
    <div class="container mt-5">
        <h1 class="mb-4">Public Posts</h1>
        <div class="row">
            <!-- Loop through posts -->
            <div
                class="col-md-4 mb-4"
                v-for="post in props.posts.data"
                :key="post.id"
            >
                <div class="card position-relative h-100 shadow-sm">
                    <!-- Tags -->
                    <div
                        v-if="post.tags && post.tags.length > 0"
                        class="position-absolute top-0 start-0 p-2"
                        style="z-index: 1"
                    >
                        <span
                            v-for="tag in post.tags"
                            :key="tag.id"
                            class="badge bg-info text-dark me-1"
                        >
                            {{ tag.name }}
                        </span>
                    </div>

                    <!-- Image or fallback -->
                    <Link :href="`/public-posts/${post.id}`">
                        <img
                            v-if="post.image"
                            :src="`/${post.image}`"
                            class="card-img-top"
                            style="height: 200px; object-fit: cover"
                            alt="Post Image"
                        />
                        <div
                            v-else
                            class="bg-light d-flex align-items-center justify-content-center card-img-top"
                            style="height: 200px"
                        >
                            <span class="text-muted fs-4">No Image</span>
                        </div>
                    </Link>

                    <!-- Card Body -->
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">
                            <Link
                                :href="`/public-posts/${post.id}`"
                                class="text-decoration-none text-dark stretched-link"
                                >{{ post.title }}</Link
                            >
                        </h5>
                        <!-- Content Preview (stripping HTML) -->
                        <p
                            class="card-text flex-grow-1"
                            style="
                                overflow: hidden;
                                display: -webkit-box;
                                -webkit-line-clamp: 3;
                                -webkit-box-orient: vertical;
                            "
                        >
                            {{ stripHtml(post.content) }}
                        </p>

                        <!-- Buttons Container -->
                        <div
                            class="mt-auto d-flex justify-content-between align-items-center"
                            style="z-index: 2; position: relative"
                        >
                            <!-- View Post Button -->
                            <Link
                                :href="`/public-posts/${post.id}`"
                                class="btn btn-sm btn-outline-primary"
                                title="View Post"
                            >
                                <i class="fas fa-eye me-1"></i> View
                            </Link>

                            <!-- Bookmark Button -->
                            <button
                                @click.stop="toggleBookmarkHandler(post.id)"
                                class="btn btn-sm"
                                :class="
                                    bookmarkedStatus[post.id]
                                        ? 'btn-warning'
                                        : 'btn-outline-secondary'
                                "
                                :disabled="!authUser"
                                :title="
                                    authUser
                                        ? bookmarkedStatus[post.id]
                                            ? 'Remove bookmark'
                                            : 'Save post'
                                        : 'Login to save posts'
                                "
                            >
                                <i
                                    :class="
                                        bookmarkedStatus[post.id]
                                            ? 'fas fa-bookmark'
                                            : 'far fa-bookmark'
                                    "
                                ></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- No Posts Message -->
            <div
                v-if="!props.posts.data || props.posts.data.length === 0"
                class="col-12 text-center mt-5"
            >
                <p class="text-muted fs-4">No public posts found.</p>
            </div>
        </div>

        <!-- Pagination -->
        <div class="d-flex justify-content-center mt-5 mb-4">
            <nav v-if="props.posts.links && props.posts.links.length > 3">
                <!-- Only show pagination if there are more than just prev/next links -->
                <ul class="pagination shadow-sm">
                    <li
                        v-for="(link, i) in props.posts.links"
                        :key="i"
                        class="page-item"
                        :class="{
                            active: link.active,
                            disabled: !link.url,
                        }"
                    >
                        <Link
                            class="page-link"
                            v-if="link.url"
                            :href="link.url"
                            v-html="link.label"
                            preserve-scroll
                            preserve-state
                        />
                        <!-- Use span for disabled links -->
                        <span
                            v-else
                            class="page-link"
                            v-html="link.label"
                            aria-disabled="true"
                        />
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</template>

<style scoped>
.card-title a:hover {
    text-decoration: underline;
    color: #0d6efd;
}
.card-text {
    line-height: 1.4;
    color: #495057;
}
.stretched-link::after {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 1;
    content: "";
}

.card-body .btn,
.card-body button {
    z-index: 2;
    position: relative;
}
</style>
