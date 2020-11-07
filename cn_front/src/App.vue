<template>
  <!--  <img alt="Vue logo" src="./assets/logo.png">-->
  <!--  <HelloWorld msg="Welcome to Your Vue.js App" optional_msg="for your Rails back end!"/>-->
  <SearchForm></SearchForm>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import SearchForm from '@/components/SearchForm.vue'
// import SearchResults from '@/components/SearchResults.vue'
// import SearchList from '@components/SearchList.vue'

export default {
  name: 'App',
  components: {
    SearchForm,
    // SearchResults,
    // SearchList
  }
}
</script>

<style>

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

</style>
