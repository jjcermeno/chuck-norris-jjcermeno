<template>
  <div class="container mt-3 mb-3">
    <div class="notification is-success has-text-centered">
      <h4 class="title">
        Search List
      </h4>
    </div>
  </div>
  <Table :openSearchResults="openSearch"></Table>
</template>

<script>
// import ApiClient from "@/services/ApiClient";
import Table from "@/components/Table.vue";

export default {
  name: 'SearchList',
  components: {
    Table
  },
  props: [
    'openSearchResults'
  ],
  data() {
    return {
      data: null
    }
  },
  methods: {
   openSearch(row) {
     this.openSearchResults(row)
    }
  }
}
</script>