<template>
  <div class="container mt-3 mb-3">
    <div class="box" v-for="joke in jokes" :key="joke">
      <article class="media">
        <div class="media-left">
          <figure class="image is-64x64">
            <img :src="joke.iconUrl" alt="chuck norris icon">
          </figure>
        </div>
        <div class="media-content">
          <div class="content">
            <p>
              <strong>Joke {{joke.id}} </strong> <small><a :href="joke.jokeUrl" target="_blank">@chuky</a></small>
              <br>
              <a :href="joke.jokeUrl" target="_blank">{{ joke.jokeValue }}</a>
            </p>
          </div>
        </div>
      </article>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Jokes',
  props: ['jokes'],
  data() {
    return {
      my_jokes: []
    }
  }
}
</script>