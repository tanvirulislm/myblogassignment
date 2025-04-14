<template>
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Recent Comments</h5>
            <ul class="list-group">
                <li
                    class="list-group-item"
                    v-for="comment in recentComments"
                    :key="comment.id"
                >
                    {{ comment.content }}<br />
                    <small class="text-muted">
                        On post:
                        <a :href="`/posts/${comment.post?.id}`">
                            {{ comment.post?.title || "Untitled Post" }}
                        </a>
                    </small>
                </li>
            </ul>
        </div>
    </div>
</template>

<script setup>
defineProps({
    recentComments: Array,
});
</script>
