<script setup>
import Navbar from "@/Components/Navbar.vue";
import { Link, usePage } from "@inertiajs/vue3";

const { props } = usePage();
const user = props.user;
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <h2>My Profile</h2>
        <div class="card p-4">
            <p><strong>Name:</strong> {{ user.username }}</p>
            <p><strong>Email:</strong> {{ user.email }}</p>

            <Link href="/reset-password" class="btn btn-warning mt-3">
                Reset Password
            </Link>
        </div>
    </div>
</template>
