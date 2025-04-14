<script setup>
import { router } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";

import DashboardStats from "@/Components/DashboardStats.vue";
import Navbar from "@/Components/Navbar.vue";
import RecentBookmarks from "@/Components/RecentBookmarks.vue";
import RecentComments from "@/Components/RecentComments.vue";
import RecentPosts from "@/Components/RecentPosts.vue";

const props = defineProps({
    recentPosts: Array,
    recentComments: Array,
    recentBookmarks: Array,
    totalPosts: Number,
    totalComments: Number,
    totalBookmarks: Number,
});

const toaster = createToaster({ position: "top-right" });

function logout() {
    router.post(
        "/user-logout",
        {},
        {
            onSuccess: () => {},
            onError: () => {
                toaster.error("Logout failed!");
            },
        }
    );
}
</script>

<template>
    <div class="dashboard">
        <Navbar />

        <div class="container mt-4">
            <h1 class="mb-4">Dashboard</h1>
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <DashboardStats
                        :total-posts="totalPosts"
                        :total-comments="totalComments"
                        :total-bookmarks="totalBookmarks"
                    />
                </div>

                <div class="col-lg-9 col-md-8">
                    <RecentPosts :posts="recentPosts" />
                    <RecentComments :recent-comments="recentComments" />

                    <RecentBookmarks :recent-bookmarks="recentBookmarks" />
                </div>
            </div>
        </div>
    </div>
</template>
