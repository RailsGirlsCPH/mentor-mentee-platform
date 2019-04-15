<template>
  <div class="input">
    <label for="search">{{ label }}:</label>
    <input
      type="text"
      id="search"
      :value="searchValue"
      @input="inputHandler"
      :placeholder="placeholder"
    />
  </div>
</template>

<script>
export default {
  name: 'SearchInput',
  props: {
    /**
     * Label text
     */
    label: {
      type: String,
      default: 'Search',
    },
    /**
     * Placeholder text
     */
    placeholder: {
      type: String,
      default: 'Type in any text',
    },
    /**
     * Input default value
     */
    searchValue: {
      type: String,
      default: '',
      isRequired: true,
    },
  },
  methods: {
    inputHandler: function(event) {
      /**
       * Pass through change event
       * @type {Input Event}
       */
      this.$emit('change', event.target.value);
    },
  },
};
</script>

<style scoped>
/* leave style for now */
.input {
  color: grey;
}
</style>
