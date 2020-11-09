<template>
  <div class="container mt-3 mb-3">
    <div class="notification is-primary has-text-centered">
      <h4 class="title">
        Jokes from Search {{ search.id }}
      </h4>
    </div>
  </div>
  <div
      v-bind:class="{ 'notification': true, 'is-success': isSuccessful, 'is-danger': isDanger, 'is-hidden': isHidden , 'is-light': false}">
    <button class="delete" @click="close_notification"></button>
    {{ notification_message }}
  </div>
  <div class="container mt-3 mb-3">
    <h6 class="title is-7 has-text-centered">Total jokes: {{ total_jokes }}</h6>
  </div>
  <div class="container mt-3 mb-3">
    <Jokes :jokes="jokes"></Jokes>
  </div>
  <div class="container mt-3 mb-3">
    <!--    <jokes-paginator :pagination_data="set_pagination_data"></jokes-paginator>-->
    <h6 class="title is-7 has-text-centered">Total jokes: {{ total_jokes }}</h6>
  </div>
  <div class="container mt-3 mb-3">
    <!--    <search-paginator :pagination_data="pagination_data" :page="page_trigger"></search-paginator>-->
    <nav class="pagination is-centered is-small" role="navigation" aria-label="pagination">
      <button :class="{'button': true, 'pagination-previous': true}"
              @click="go_to_first">First
      </button>
      <button :class="{'button': true, 'pagination-previous': true, 'is-hidden':isPreviousHidden}"
              @click="go_to_previous">Previous
      </button>
      <button :class="{'button': true,'pagination-next': true, 'is-hidden':isNextHidden}" @click="go_to_next">Next
        page
      </button>
      <button :class="{'button': true, 'pagination-next': true}"
              @click="go_to_last">Last
      </button>
      <ul class="pagination-list">
        <li><a class="pagination-link is-current">Page {{ page }}/{{ total_pages }}</a></li>
      </ul>
    </nav>
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
      jokes: [],
      isSuccessful: false,
      isDanger: true,
      isHidden: true,
      notification_message: '',
      isPreviousHidden: true,
      isNextHidden: true
    }
  },
  methods: {
    openSearch(id) {
      this.getSearch(id)
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
      this.set_buttons_status()
    },
    open_success_notification(message) {
      this.isSuccessful = true
      this.isDanger = false
      this.isHidden = false
      this.notification_message = message
    },
    open_error_notification(message) {
      this.isSuccessful = false
      this.isDanger = true
      this.isHidden = false
      this.notification_message = message
    },
    close_notification() {
      this.isHidden = true
    },
    go_to_previous() {
      if (this.page > 1) {
        this.page -= 1
      }
      this.set_buttons_status()
      this.getSearch(this.search.id)
    },
    go_to_next() {
      if (this.page < this.total_pages) {
        this.page += 1
      }
      this.set_buttons_status()
      this.getSearch(this.search.id)
    },
    go_to_first() {
      this.page = 1
      this.set_buttons_status()
      this.getSearch(this.search.id)
    },
    go_to_last() {
      this.page = this.total_pages
      this.set_buttons_status()
      this.getSearch(this.search.id)
    },
    set_buttons_status() {
      this.isPreviousHidden = !(this.page > 1)
      this.isNextHidden = !(this.page < this.total_pages)
    },
    getSearch(id) {
      if (this.search) {
        if (!(this.search.id === id)) {
          this.page = 1
          this.total_pages = 1
          this.total_jokes = 0
        }
      }else{
        this.page = 1
        this.total_pages = 1
        this.total_jokes = 0
      }
      const page = this.page
      const per_page = this.per_page
      ApiClient.getSearch(id, page, per_page)
          .then(response => this.setData(response.data))
          .catch(error => {
            this.api_errors = error
            // alert("There was some errors when trying to get search data, sorry. Check the console for more info.")
            this.open_error_notification("There was some errors when getting the search, sorry. Check the console for more info.")
            console.log(JSON.stringify(error))
          })

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