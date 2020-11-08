<template>
  <div class="container mt-3 mb-3">
    <div class="notification is-danger has-text-centered">
      <h4 class="title">
        Search for Chuck Norris' jokes!
      </h4>
    </div>
    <div class="box">

      <div class="field">
        <input
            type="email"
            class="input"
            name="email"
            v-model="email"
            placeholder="enter valid email address if you want jokes in your Inbox..."
            @blur="validateEmail">

        <p class="help is-danger" v-if="errors.email">
          Please enter a valid email.
        </p>
      </div>

      <div class="level">
        <div class="level-left">
          <div class="level-item">
            <label class="label">Search by word(s):</label>
          </div>
          <div class="level-item">
            <div class="field has-addons">
              <div class="control">
                <input type="text" class="input" name="word" v-model="word">
              </div>
              <div class="control" :disabled="disabled === true">
                <button class="button is-danger" :disabled="disabled === true" @click="searchByWord">
                  Go!
                </button>
              </div>
            </div>
          </div>
        </div>
        <div class="level-right">
          <div class="level-item">
            <label class="label">Search by category:</label>
          </div>
          <div class="level-item">
            <div class="field has-addons">
              <div class="control is-expanded">
                <div class="select is-fullwidth" v-if="categories">
                  <select name="category" v-model="category">
                    <option v-for= "category in categories" :key="category">{{ category.categoryName }}</option>
                  </select>
                </div>
              </div>
              <div class="control">
                <button class="button is-info" :disabled="disabled === true" @click="searchByCategory">Go!</button>
                <button class="button is-warning" @click="getCategories">Refresh categories</button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="container ">
        <button class="button is-fullwidth is-link" :disabled="disabled === true" @click="searchByRandom">Random Search, I'm feeling lucky</button>
      </div>
    </div>
  </div>
</template>

<script>
import ApiClient from "@/services/ApiClient";

export default {
  name: 'SearchForm',
  props: [
    'openSearchResults'
  ],
  data() {
    return {
      email: '',
      categories: [],
      search_type: null,
      search_value: null,
      server_info: null,
      errors: {
        email: false,
        api_errors: null
      },
      word: null,
      category: null,
      disabled: false,
      re: /^(([^<>()\]\\.,;:\s@"]+(\.[^<>()\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,24}))$/
    }
  },
  methods: {
    processForm() {
      const form = {
        searchType: this.search_type,
        searchValue: this.search_value,
        email: this.email
      }
      if (form.searchType != "random" ){
       if (form.searchValue == null || form.searchValue == ''){
        alert("I'm sorry but, when using 'word' or 'category' search you have to enter/choose something")
        return
       }
      }
      this.createSearch(form)
    },
    searchByWord() {
      this.search_type = "word"
      this.search_value = this.word
      this.processForm()
    },
    searchByCategory() {
      this.search_type = "category"
      this.search_value = this.category
      this.processForm()
    },
    searchByRandom() {
      this.search_type = "random"
      this.search_value = null
      this.processForm()
    },
    validateEmail() {
      if (this.email) {
        this.errors.email = !this.isValidEmail(this.email)
        this.disabled = this.errors.email
      } else {
        this.disabled = false
        return true
      }
    },
    isValidEmail() {
      const regex = this.re
      return regex.test(this.email);
    },
    getCategories() {
      ApiClient.getCategories()
          .then(response => this.loadCategories(response.data))
          .catch(error => this.errors.api_errors = error)
    },
    loadCategories(data) {
      this.categories = data.data
    },
    getServerInfo() {
      ApiClient.getServerInfo()
          .then(response => this.server_info = response.data)
          .catch(error => this.api_errors = error)
    },
    createSearch(form_data) {
      ApiClient.createSearch(form_data)
          .then(response => {
            const id = response.data.data[0].id
            this.resetFields()
            this.openSearch({id: id})
          })
          .catch(error => {
            this.api_errors = error
            alert(JSON.stringify(this.api_errors))
          })
    },
    resetFields() {
      this.email = null
    },
    openSearch(row) {
      this.openSearchResults(row)
    }
  },
  created() {
    this.getCategories()
    this.getServerInfo()
    this.validateEmail()
  }
}
</script>