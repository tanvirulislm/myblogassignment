<script setup>
const props = defineProps({
    totalPosts: Number,
    totalComments: Number,
    totalBookmarks: Number,
});
</script>
<template>
    <div>
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Total Posts</h5>
                <p class="card-text">{{ totalPosts }}</p>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Total Comments</h5>
                <p class="card-text">{{ totalComments }}</p>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Total Bookmarks</h5>
                <p class="card-text">{{ totalBookmarks }}</p>
            </div>
        </div>
    </div>
</template>
