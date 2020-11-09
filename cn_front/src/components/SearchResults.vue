<template>
  <div class="container mt-3 mb-3">
    <div class="notification is-primary has-text-centered">
      <h4 class="title">
        Jokes from Search {{ search.id }}
      </h4>
    </div>
  </div>
  <div class="container mt-3 mb-3">
    <Jokes :jokes="jokes"></Jokes>
  </div>
  <div class="container mt-3 mb-3">
<!--    <jokes-paginator :pagination_data="set_pagination_data"></jokes-paginator>-->
  </div>

</template>

<script>
import Jokes from "@/components/Jokes.vue";
// import Paginator from "@/components/Paginator.vue";
import ApiClient from "@/services/ApiClient";

export default {
  name: 'SearchResults',
  components: {
    Jokes,
    // 'jokes-paginator': Paginator
  },
  props: ['search_id'],
  data() {
    return {
      search: {},
      total_jokes: 0,
      total_pages: 1,
      page: 1,
      per_page: 5,
      api_errors: null,
      jokes: []
    }
  },
  methods: {
    set_pagination_data() {
      return {
        total_items: this.search.meta.totalJokes,
        total_pages: this.search.meta.totalPages,
        page_number: this.search.meta.pageNumber,
        page_size: this.search.meta.pageSize
      }
    },
    openSearch(id) {
      ApiClient.getSearch(id)
          .then(response => this.setData(response.data))
          .catch(error => {
            this.api_errors = error
            alert("There was some errors when getting the search, sorry. Check the console for more info.")
            console.log(JSON.stringify(error))
          })
    },
    set_jokes() {
      return this.jokes
    },
    setData(data) {
      this.search = data.data[0]
      this.jokes = this.search.jokes
      this.total_jokes = data.meta.totalJokes
      this.total_pages = data.meta.totalPages
      this.page = data.meta.pageNumber
      this.per_page = data.meta.pageSize
    }
  },
  watch: {
    search_id: function (newVal) {
      if (newVal) {
        this.openSearch(newVal);
      }
    }
  }
}
</script>