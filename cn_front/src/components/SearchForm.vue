<template>
  <div class="container mt-3 mb-3">
    <div class="notification is-danger has-text-centered">
      <h4 class="title">
        Search for Chuck Norris' jokes!
      </h4>
    </div>
    <div class="box">
      <!-- our signup form ===================== -->
      <form id="signup-form" @submit.prevent="processForm">
        <!-- name -->
        <div class="field">
          <label class="label">Name</label>
          <input
              type="text"
              class="input"
              name="name"
              v-model="name">
        </div>

        <!-- email -->
        <div class="field">
          <label class="label">Email</label>
          <input
              type="email"
              class="input"
              name="email"
              v-model="email"
              @blur="validateEmail">

          <p class="help is-danger" v-if="errors.email">
            Please enter a valid email.
          </p>
        </div>

        <!-- submit button -->
        <div class="field has-text-right">
          <button type="submit" class="button is-danger">
            Submit
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import ApiClient from "@/services/ApiClient";

export default {
  name: 'SearchForm',
  data() {
    return {
      name: '',
      email: '',
      errors: {
        name: false,
        email: false
      },
      search: null,
      api_errors: null,
      categories: [],
      server_info: null
    }
  },
  methods: {
    processForm() {
      console.log({name: this.name, email: this.email});
      alert('Processing');
    },
    validateEmail() {
      const isValid = window.isValidEmail(this.email);
      this.errors.email = !isValid;
    },
    getCategories() {
      ApiClient.getCategories()
          .then(response => this.categories = response.data)
          .catch(error => this.api_errors = error)
    },
    getServerInfo() {
      ApiClient.getServerInfo()
          .then(response => this.server_info = response.data)
          .catch(error => this.api_errors = error)
    }
  },
  created() {
    this.getCategories();
    this.getServerInfo();
    console.log(this.categories);
    console.log(this.server_info);
  }
}
</script>