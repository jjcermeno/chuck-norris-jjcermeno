<template>
  <td>{{ row.id }}</td>
  <td>{{ row.searchType }}</td>
  <td>{{ row.searchValue }}</td>
  <td>{{ row.email }}</td>
  <td>{{ row.totalJokes }}</td>
  <td>
    <button class="button is-rounded is-success is-small" @click="openSearchResults(row)">Open Jokes</button>
    <button class="button is-rounded is-link is-small" @click="resendEmail(row)" v-if="row.email">Resend Email</button>
  </td>
</template>

<script>
import ApiClient from "@/services/ApiClient";

export default {
  name: 'TableRow',
  props: [
    'row',
    'openSearchResults'],
  data() {
    return {
      isSuccessful: false,
      isDanger: true,
      isHidden: true,
      notification_message: ''
    }
  },
  methods: {
    resendEmail(row) {
      ApiClient.resendEmail(row.id)
        .then(response => {
          console.log(response.data)
        }).catch(error => {
          alert("There was some errors when requesting resending the email, sorry. Check the console for more info.")
          console.log(JSON.stringify(error))
        })
    }
  },
  created() {

  },
  updated() {
  },
  mounted() {
  }
}
</script>