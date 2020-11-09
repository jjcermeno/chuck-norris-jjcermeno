<template>
  <nav class="pagination is-centered is-small is-rounded" role="navigation" aria-label="pagination">
    <button :class="{'button': true, 'pagination-previous': true, 'is-hidden':isPreviousHidden}"
            @click="go_to_previous">Previous
    </button>
    <button :class="{'button': true,'pagination-next': true, 'is-hidden':isNextHidden}" @click="go_to_next">Next page</button>
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
        page_size: 5
      },
      page_trigger: '',
      isPreviousHidden: true,
      isNextHidden: true
    }
  },
  methods: {
    go_to_previous() {
      if (this.pagination_data.page <= 1) {
        console.log("Page in paginator: ", this.pagination_data.page_number)
      } else {
        this.pagination_data.page_number -= 1
        console.log("Page in paginator: ", this.pagination_data.page_number)
      }
      this.set_buttons_status()
    },
    go_to_next() {
      if (this.pagination_data.page < this.pagination_data.total_pages) {
        this.pagination_data.page_number += 1
        console.log("Page in paginator: ", this.pagination_data.page_number)
      } else {
        console.log("Page in paginator: ", this.pagination_data.page_number)
      }
      this.set_buttons_status()
    },
    set_buttons_status() {
      console.log("Paginator (table)", JSON.stringify(this.pagination_data));
      var page = this.pagination_data.page_number
      var total_pages = this.pagination_data.page_number
      console.log("Paginator (table) page: ", page);
      this.isPreviousHidden = !(page > 1)
      this.isNextHidden = !(page < total_pages)
      this.show_buttons_status()
    },
    show_buttons_status(){
      console.log("PREVIOUS IS SHOWED?", !this.isPreviousHidden)
      console.log("NEXT IS SHOWED?", !this.isNextHidden)
      console.log("CURRENT PAGE", this.pagination_data.page_number)
    }
  },
  created() {
    this.set_buttons_status()
  },
  updated() {
    // console.log("Paginator updated", JSON.stringify(this.pagination_data));
  }
}
</script>