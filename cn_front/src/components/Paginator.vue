<template>
  <nav class="pagination is-centered is-small is-rounded" role="navigation" aria-label="pagination">
    <a class="pagination-previous">Previous</a>
    <a class="pagination-next">Next page</a>
    <ul class="pagination-list">
      <li><a class="pagination-link" aria-label="Goto page 1">1</a></li>
      <li><span class="pagination-ellipsis">&hellip;</span></li>
      <li><a class="pagination-link" aria-label="Goto page 45">45</a></li>
      <li><a class="pagination-link is-current" aria-label="Page 46" aria-current="page">46</a></li>
      <li><a class="pagination-link" aria-label="Goto page 47">47</a></li>
      <li><span class="pagination-ellipsis">&hellip;</span></li>
      <li><a class="pagination-link" aria-label="Goto page 86">86</a></li>
    </ul>
  </nav>
</template>

<script>

export default {
  name: 'Paginator',
  data() {
    return {
      pagination_data: {
        total_pages: 1,
        page_number: 1,
        page_size: 5,
        total_items: 0
      }
    }
  },
  methods: {
    setPaginationData(pagination_data) {
      console.log("Setting pagination data", JSON.stringify(pagination_data));
    }
  },
  created() {
    // console.log("Paginator created", JSON.stringify(this.pagination_data));
    // this.setPaginationData(null);
  },
  updated() {
    // console.log("Paginator updated", JSON.stringify(this.pagination_data));
  }
}
</script>