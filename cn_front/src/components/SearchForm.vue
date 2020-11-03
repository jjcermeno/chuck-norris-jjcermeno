<template>
  <div class="hero is-fullheight is-info is-bold">
    <div class="hero-body">
      <div class="container">
        <h1 class="title has-text-centered">Vue.js Form Processing</h1>
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
    </div>
  </div>
</template>

<script>
import ApiClient from "@/services/ApiClient";
export default {
  name: 'SearchForm',
  data () {
    return {
      name: '',
      email: '',
      errors: {
        name: false,
        email: false
      },
      search: null,
      api_errors: null
    }
  },
  methods: {
    processForm () {
      console.log({ name: this.name, email: this.email });
      alert('Processing');
    },
    validateEmail () {
      const isValid = window.isValidEmail(this.email);
      this.errors.email = !isValid;
    },
    getSearches () {
      ApiClient.getSearches()
      .then(response => this.search = response.data)
      .catch(error => this.api_errors = error)
    }
  }
}
</script>