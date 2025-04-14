<script setup>
import { defineProps, ref } from "vue";
import { Link, router } from "@inertiajs/vue3";
import Navbar from "@/Components/Navbar.vue";
const props = defineProps({
    posts: Array,
});

// For table headers
const headers = [
    { text: "Title", value: "title" },
    { text: "Image", value: "image" },
    { text: "Visibility", value: "visibility" },
    { text: "Actions", value: "actions" },
];

// Search
const searchField = ref("");

// Actions
function editPost(id) {
    router.visit(`/edit-post/${id}`);
}

function deletePost(id) {
    if (confirm("Are you sure you want to delete this post?")) {
        router.post(
            `/delete-post/${id}`,
            {},
            {
                onSuccess: () => alert("Post deleted!"),
            }
        );
    }
}
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <h2>All My Posts</h2>

        <!-- Search Bar -->
        <input
            type="text"
            class="form-control mb-3"
            placeholder="Search by title..."
            v-model="searchField"
        />

        <!-- Data Table -->
        <EasyDataTable
            :headers="headers"
            :items="props.posts"
            :search-value="searchField"
            :rows-per-page="5"
            table-class-name="custom-table"
        >
            <!-- Image -->
            <template #item-image="{ image }">
                <img
                    :src="`/${image}`"
                    alt="Post Image"
                    class="img-thumbnail"
                    style="max-height: 60px"
                />
            </template>

            <!-- Actions -->
            <template #item-actions="{ id }">
                <button
                    @click="editPost(id)"
                    class="btn btn-sm btn-primary me-2"
                >
                    Edit
                </button>
                <button @click="deletePost(id)" class="btn btn-sm btn-danger">
                    Delete
                </button>
            </template>
        </EasyDataTable>
    </div>
</template>

<style scoped>
.custom-table {
    margin-top: 20px;
}
</style>
