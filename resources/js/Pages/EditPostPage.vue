<script setup>
import Navbar from "@/Components/Navbar.vue";
import { useForm } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";
import { ref } from "vue"; // Import watch

// 1. Import QuillEditor and its CSS
import { QuillEditor } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.snow.css"; // Or use vue-quill.bubble.css

const props = defineProps({
    post: Object,
    // Remove tagIds, we get tags from post.tags now
    // tagIds: Array,
});

const toaster = createToaster();

const previewImage = ref(props.post.image ? `/${props.post.image}` : null);

// --- Tag Management State ---
const tagInput = ref("");
// Initialize currentTags with the names from the post prop
const currentTags = ref(
    props.post.tags ? props.post.tags.map((t) => t.name) : []
);
// --- End Tag Management State ---

const form = useForm({
    id: props.post.id,
    title: props.post.title,
    // Initialize content for Quill
    content: props.post.content,
    visibility: props.post.visibility,
    image: null, // Will be populated if a new image is selected
    // Initialize form.tags - we'll update this before submitting
    tags: [], // Keep this empty initially or sync with currentTags if preferred
});

// --- Tag Management Functions ---
const addTag = () => {
    const name = tagInput.value.trim();
    if (name && !currentTags.value.includes(name)) {
        currentTags.value.push(name);
    }
    tagInput.value = "";
};

const removeTag = (name) => {
    currentTags.value = currentTags.value.filter((t) => t !== name);
};
// --- End Tag Management Functions ---

function handleFileChange(event) {
    const file = event.target.files[0];
    if (file) {
        form.image = file;
        // Clean up previous object URL if exists
        if (previewImage.value && previewImage.value.startsWith("blob:")) {
            URL.revokeObjectURL(previewImage.value);
        }
        previewImage.value = URL.createObjectURL(file);
    }
}

function updatePost() {
    // *** Crucial: Update form.tags with the current state before submitting ***
    form.tags = currentTags.value;

    form.post("/update-post", {
        forceFormData: true, // Necessary because we might send a file OR need to override PUT/PATCH method
        onSuccess: () => {
            toaster.success("Post updated successfully!");
            // Optional: Redirect or perform other actions
            // router.visit('/dashboard'); // Example redirect
        },
        onError: (errors) => {
            console.error("Update Errors:", errors); // Log errors for debugging
            toaster.error(
                errors.title ||
                    errors.content ||
                    errors.tags ||
                    "Update failed. Please check your inputs."
            );
        },
    });
}

// Optional: Clean up the object URL when the component is unmounted
import { onUnmounted } from "vue";
onUnmounted(() => {
    if (previewImage.value && previewImage.value.startsWith("blob:")) {
        URL.revokeObjectURL(previewImage.value);
    }
});
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <h2>Edit Post</h2>

        <form @submit.prevent="updatePost" enctype="multipart/form-data">
            <!-- Title -->
            <div class="mb-3">
                <label for="title" class="form-label">Post Title</label>
                <input
                    v-model="form.title"
                    type="text"
                    id="title"
                    class="form-control"
                    required
                />
                <div v-if="form.errors.title" class="text-danger mt-1">
                    {{ form.errors.title }}
                </div>
            </div>

            <!-- Content -->
            <div class="mb-3">
                <label for="content" class="form-label">Content</label>
                <!-- 2. Replace textarea with QuillEditor -->
                <!-- 3. Bind content using v-model:content -->
                <QuillEditor
                    v-model:content="form.content"
                    theme="snow"
                    contentType="html"
                    toolbar="essential"
                    style="min-height: 200px"
                    id="content"
                />
                <div v-if="form.errors.content" class="text-danger mt-1">
                    {{ form.errors.content }}
                </div>
                <!-- Remove the old textarea:
                <textarea
                    v-model="form.content"
                    id="content"
                    class="form-control"
                    rows="6"
                    required
                ></textarea>
                -->
            </div>

            <!-- Visibility -->
            <div class="mb-3">
                <label for="visibility" class="form-label">Visibility</label>
                <select
                    v-model="form.visibility"
                    id="visibility"
                    class="form-control"
                >
                    <option value="public">Public</option>
                    <option value="private">Private</option>
                </select>
                <div v-if="form.errors.visibility" class="text-danger mt-1">
                    {{ form.errors.visibility }}
                </div>
            </div>

            <!-- Tags -->
            <div class="mb-3">
                <label>Tags</label>
                <div class="d-flex">
                    <input
                        v-model="tagInput"
                        @keyup.enter.prevent="addTag"
                        placeholder="Type tag and hit Enter"
                        class="form-control me-2"
                    />
                    <button
                        type="button"
                        @click="addTag"
                        class="btn btn-secondary"
                    >
                        Add
                    </button>
                </div>
                <div class="mt-2">
                    <span
                        v-for="tag in currentTags"
                        :key="tag"
                        class="badge bg-primary me-1"
                    >
                        {{ tag }}
                        <span
                            @click="removeTag(tag)"
                            style="cursor: pointer; margin-left: 4px"
                            >&times;</span
                        >
                    </span>
                </div>
                <div v-if="form.errors.tags" class="text-danger mt-1">
                    {{ form.errors.tags }}
                </div>
            </div>

            <!-- Image Upload -->
            <div class="mb-3">
                <label for="image" class="form-label"
                    >Thumbnail Image (Optional: Replace existing)</label
                >
                <input
                    type="file"
                    id="image"
                    class="form-control"
                    accept="image/*"
                    @change="handleFileChange"
                />
                <div v-if="form.errors.image" class="text-danger mt-1">
                    {{ form.errors.image }}
                </div>
                <div v-if="previewImage" class="mt-3">
                    <p>Current/New Image Preview:</p>
                    <img
                        :src="previewImage"
                        alt="Image Preview"
                        class="img-fluid rounded"
                        style="max-height: 300px"
                    />
                </div>
            </div>

            <!-- Submit -->
            <button
                type="submit"
                class="btn btn-success"
                :disabled="form.processing"
            >
                {{ form.processing ? "Updating..." : "Update Post" }}
            </button>
        </form>
    </div>
</template>

<style scoped>
.container {
    max-width: 800px;
}
/* Add Quill editor styles if needed, though theme CSS usually suffices */
.ql-editor {
    min-height: 200px; /* Ensure editor has a minimum height */
}
.text-danger {
    font-size: 0.875em;
}
</style>
