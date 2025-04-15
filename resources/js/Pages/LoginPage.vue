<script setup>
import { router } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";
import { ref } from "vue";
import Navbar from "@/Components/Navbar.vue";

const toaster = createToaster();
const formData = ref({
    email: "",
    password: "",
});

function login() {
    router.post("/user-login", formData.value, {
        onSuccess: () => {
            toaster.success("Login successful!");
            router.visit("/dashboard"); // ✅ Redirect using Inertia
        },
        onError: (errors) => {
            if (errors.message) {
                toaster.error(errors.message);
            } else {
                toaster.error("Something went wrong!");
            }
        },
    });
}
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <h2 class="text-center">Login</h2>
                <form @submit.prevent="login">
                    <div class="mb-3">
                        <label>Email</label>
                        <input
                            v-model="formData.email"
                            type="email"
                            class="form-control"
                            required
                        />
                    </div>
                    <div class="mb-3">
                        <label>Password</label>
                        <input
                            v-model="formData.password"
                            type="password"
                            class="form-control"
                            required
                        />
                    </div>
                    <button type="submit" class="btn btn-primary w-100">
                        Login
                    </button>
                </form>
            </div>
        </div>
        <!-- You do not have account please login -->
        <div class="mt-3 text-center">
            <p>
                Don't have an account?
                <a href="/user-register">Register</a>
            </p>
        </div>
    </div>
</template>

<style scoped>
.container {
    margin-top: 100px;
}
</style>
