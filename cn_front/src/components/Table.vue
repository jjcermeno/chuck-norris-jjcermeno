<template>
  <h6 class="title is-6 has-text-centered">Searches in total: {{ total_searches }}</h6>
  <div class="container mt-3 mb-3">
    <table class="table is-hoverable is-success is-fullwidth">
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
          <TableRow :row="row" :openSearchResults="openSearch"></TableRow>
        </tr>
      </tbody>
    </table>
  </div>
  <h6 class="title is-6 has-text-centered">Searches in total: {{ total_searches }}</h6>
  <div class="container mt-3 mb-3">
    <Paginator :pagination_data="pagination_data"></Paginator>
  </div>
</template>

<script>
import Paginator from "@/components/Paginator.vue";
import TableRow from "@/components/TableRow.vue";
import ApiClient from "@/services/ApiClient";

export default {
  name: 'Table',
  components: {
    Paginator,
    TableRow
  },
  props: [
      'openSearchResults'
  ],
  data() {
    return {
      rows: [],
      total_pages: 1,
      page: 1,
      per_page: 50,
      total_searches: 0,
      api_errors: ''
    }
  },
  methods: {
    getData() {
      const form = {
        page_size: this.per_page,
        page_number: this.page
      }
      this.getSearches(form)
    },
    setData(data) {
      this.rows = data.data
      this.total_searches = data.meta.totalSearches
      this.total_pages = data.meta.totalPages
      this.page = data.meta.pageNumber
      this.per_page = data.meta.pageSize
    },
    getSearches(form) {
      ApiClient.getSearches(form.page_number, form.page_size)
          .then(response => this.setData(response.data))
          .catch(error => this.api_errors = error)
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
    }
  },
  created() {
    this.getData();
  },
  updated() {
  },
  mounted() {
  }
}
</script>