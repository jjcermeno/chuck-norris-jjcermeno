<template>
  <h6 class="title is-6 has-text-centered">Searches in total: {{ total_searches }}</h6>
  <div v-bind:class="{ 'notification': true, 'is-success': isSuccessful, 'is-danger': isDanger, 'is-hidden': isHidden , 'is-light': false}">
    <button class="delete" @click="close_notification"></button>
    {{ notification_message }}
  </div>
  <div class="container mt-3 mb-3">
    <table class="table is-hoverable is-narrowed is-success is-fullwidth">
      <thead>
      <tr>
        <th>ID</th>
        <th><abbr title="Search Type">Type</abbr></th>
        <th><abbr title="Search Value">Value</abbr></th>
        <th><abbr title="Email">Email</abbr></th>
        <th><abbr title="Jokes">Jokes</abbr></th>
        <th><abbr title="Action"></abbr></th>
      </tr>
      </thead>
      <tfoot>
      <tr>
        <th>ID</th>
        <th><abbr title="Search Type">Type</abbr></th>
        <th><abbr title="Search Value">Value</abbr></th>
        <th><abbr title="Email">Email</abbr></th>
        <th><abbr title="Jokes">Jokes</abbr></th>
        <th><abbr title="Action"></abbr></th>
      </tr>
      </tfoot>
      <tbody v-if="rows">
        <tr v-for="row in rows" :key="row">
          <table_row :row="row" :openSearchResults="openSearch"></table_row>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="container mt-3 mb-3">
    <h6 class="title is-6 has-text-centered">Searches in total: {{ total_searches }}</h6>
    <!--    <button class="button is-small is-warning" @click="getData">Refresh table</button>-->
  </div>
  <div class="container mt-3 mb-3">
    <search-paginator :pagination_data="pagination_data" :page="page_trigger"></search-paginator>
  </div>
</template>

<script>
import Paginator from "@/components/Paginator.vue";
import TableRow from "@/components/TableRow.vue";
import ApiClient from "@/services/ApiClient";

export default {
  name: 'Table',
  components: {
    'table_row': TableRow,
    'search-paginator': Paginator
  },
  props: [
    'openSearchResults',
    'page_trigger',
  ],
  data() {
    return {
      rows: [],
      total_pages: 0,
      page: 1,
      per_page: 5,
      total_searches: 0,
      api_errors: '',
      isSuccessful: false,
      isDanger: true,
      isHidden: true,
      notification_message: ''
    }
  },
  methods: {
    setData(data) {
      this.rows = data.data
      this.total_searches = data.meta.totalSearches
      this.total_pages = data.meta.totalPages
      this.page = data.meta.pageNumber
      this.per_page = data.meta.pageSize
      this.pagination_data()
    },
    getSearches() {
      var page = this.page
      if (this.page == 0){
        page = 1
      }
      const per_page = this.per_page
      ApiClient.getSearches(page, per_page)
          .then(response => this.setData(response.data))
          .catch(error => {
            this.api_errors = error
            // alert("There was some errors when trying to get search data, sorry. Check the console for more info.")
            this.open_error_notification("There was some errors when creating the search, sorry. Check the console for more info.")
            console.log(JSON.stringify(error))
          })
    },
    pagination_data() {
      return {
        total_pages: this.total_pages,
        page_number: this.page,
        page_size: this.per_page
      }
    },
    openSearch(row) {
      this.openSearchResults(row)
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
    }
  },
  created() {
    this.getSearches()
  },
  mounted() {
    this.getSearches()
  },
  watch: {
    page_trigger: function (newVal) {
      console.log("Change page: ", newVal)
      if (newVal) {
        this.page = newVal
        this.getSearches()
        this.pagination_data()
      }
    }
  }
}
</script>