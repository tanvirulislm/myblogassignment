<script setup>
import Navbar from "@/Components/Navbar.vue";
import { router, useForm } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";

const toaster = createToaster();
const form = useForm({ password: "" });

function resetPassword() {
    if (form.password.length === 0) {
        toaster.error("Password is required");
        return;
    }

    form.post("/reset-password", {
        preserveState: true,
        onSuccess: () => {
            toaster.success("Password reset successfully");
            router.push("/user-login");
        },
        onError: (errors) => {
            toaster.error(
                errors.password ? errors.password[0] : "An error occurred"
            );
        },
    });
}
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header text-center bg-danger text-white">
                        <h3>Reset Password</h3>
                    </div>
                    <div class="card-body">
                        <form @submit.prevent="resetPassword">
                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <input
                                    type="password"
                                    class="form-control"
                                    v-model="form.password"
                                />
                            </div>
                            <button type="submit" class="btn btn-danger w-100">
                                Reset Password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped></style>
