<script setup>
import { router, useForm } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";

const toaster = createToaster();
const form = useForm({
    username: "",
    email: "",
    password: "",
    password_confirmation: "",
});

function submit() {
    if (!form.username) {
        toaster.error("Username is required");
        return;
    }
    if (!form.email) {
        toaster.error("Email is required");
        return;
    }
    if (!form.password) {
        toaster.error("Password is required");
        return;
    }
    if (form.password !== form.password_confirmation) {
        toaster.error("Passwords do not match");
        return;
    }

    form.post("/user-registration", {
        onSuccess: () => {
            toaster.success("Registration successful! Redirecting to login...");
            router.push("/user-login");
        },
        onError: (errors) => {
            if (errors.username) toaster.error(errors.username[0]);
            if (errors.email) toaster.error(errors.email[0]);
            if (errors.password) toaster.error(errors.password[0]);
        },
    });
}
</script>

<template>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header text-center bg-primary text-white">
                        <h3>Register</h3>
                    </div>
                    <div class="card-body">
                        <form @submit.prevent="submit">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.username"
                                />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input
                                    type="email"
                                    class="form-control"
                                    v-model="form.email"
                                />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input
                                    type="password"
                                    class="form-control"
                                    v-model="form.password"
                                />
                            </div>

                            <div class="mb-3">
                                <label class="form-label"
                                    >Confirm Password</label
                                >
                                <input
                                    type="password"
                                    class="form-control"
                                    v-model="form.password_confirmation"
                                />
                            </div>

                            <button type="submit" class="btn btn-primary w-100">
                                Register
                            </button>
                        </form>
                        <div class="mt-3 text-center">
                            <p>
                                Already have an account?
                                <a href="/login">Login</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped></style>
