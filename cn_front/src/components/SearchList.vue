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
    refreshData() {
      // console.log("Refreshing Search list data")
    },
    openSearch(row) {
      this.openSearchResults(row)
    }
  },
  created() {
    // console.log("Search List created");
    this.refreshData();
  },
  updated() {
    // console.log("Search List updated");
  }
}
</script>