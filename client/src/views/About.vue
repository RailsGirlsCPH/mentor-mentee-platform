<template>
  <div class="about">
    <h1>This is an about page</h1>
    <input v-model="message" placeholder="Write something" />
    <text-input :searchValue="message" @change="message = $event" />
    <p>{{ message }}</p>
  </div>
</template>

<script>
import TextInput from '../components/TextInput.vue';

export default {
  name: 'About',
  components: {
    'text-input': TextInput,
  },
  data: function() {
    return {
      message: '',
    };
  },
};
</script>

<style scoped>
/* placeholder */
</style>
