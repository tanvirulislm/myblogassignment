<template>
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container">
            <!-- Brand Logo -->
            <Link
                class="navbar-brand"
                :href="user ? '/dashboard' : '/public-posts'"
                >My Blog</Link
            >

            <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation"
            >
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <!-- Public Posts Link (Visible to All) -->
                    <li class="nav-item me-2">
                        <Link
                            href="/public-posts"
                            class="nav-link"
                            :class="{ active: $page.url === '/public-posts' }"
                        >
                            Public Feed
                        </Link>
                    </li>

                    <!-- If user is authenticated -->
                    <template v-if="user">
                        <li class="nav-item me-2">
                            <Link
                                href="/all-posts"
                                class="nav-link"
                                :class="{ active: $page.url === '/all-posts' }"
                            >
                                My Posts
                            </Link>
                        </li>
                        <li class="nav-item me-3">
                            <!-- Added margin -->
                            <Link
                                href="/profile"
                                class="nav-link"
                                :class="{ active: $page.url === '/profile' }"
                            >
                                Profile
                            </Link>
                        </li>
                        <li class="nav-item me-2">
                            <Link
                                href="/create-post"
                                class="btn btn-sm btn-primary"
                            >
                                Create Post
                            </Link>
                        </li>
                        <li class="nav-item">
                            <Link
                                href="/user-logout"
                                method="post"
                                as="button"
                                class="btn btn-sm btn-danger"
                            >
                                Logout
                            </Link>
                        </li>
                    </template>

                    <!-- If user is not authenticated -->
                    <template v-else>
                        <li class="nav-item me-2">
                            <Link
                                href="/login"
                                class="btn btn-sm btn-outline-primary"
                            >
                                Login
                            </Link>
                        </li>
                        <li class="nav-item">
                            <Link
                                href="/user-register"
                                class="btn btn-sm btn-success"
                            >
                                Register
                            </Link>
                        </li>
                    </template>
                </ul>
            </div>
        </div>
    </nav>
</template>

<script setup>
import { Link, usePage } from "@inertiajs/vue3";
import { computed } from "vue";

// Get current user from Inertia shared props
const page = usePage();
const user = computed(() => page.props.auth?.user ?? null);
</script>

<style scoped>
/* Optional: Add active class styling */
.nav-link.active {
    font-weight: bold;
    color: #0d6efd !important;
}
</style>
