<script setup>
import { Link } from "@inertiajs/vue3";
</script>

<template>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <h1 class="display-4 fw-bold">Welcome to Our Blog</h1>
                <p class="lead">
                    Discover amazing posts or start sharing your thoughts.
                </p>

                <div class="mt-4">
                    <Link
                        href="/public-posts"
                        class="btn btn-success btn-lg me-3"
                        >Read Blogs</Link
                    >
                    <Link
                        href="/user-register"
                        class="btn btn-primary me-2 btn-lg"
                        >Register</Link
                    >
                    <Link href="/login" class="btn btn-success btn-lg"
                        >Login</Link
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped></style>
