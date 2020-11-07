<template>
  <div class="container">
    <div class="notification is-primary">
      This container is <strong>centered</strong> on desktop and larger viewports.
    </div>
  </div>
  <div class="hero is-fullheight is-info is-bold">
    <div class="hero-body">
      <div class="container">
        <h1 class="title has-text-centered">Vue.js Form Processing</h1>
        <div class="box">

          <!-- our signup form ===================== -->
          <form id="signup-form" @submit.prevent="processForm">
            <!-- name -->
            <div class="field">
              <label class="label">Name</label>
              <input
                  type="text"
                  class="input"
                  name="name"
                  v-model="name">
            </div>

            <!-- email -->
            <div class="field">
              <label class="label">Email</label>
              <input
                  type="email"
                  class="input"
                  name="email"
                  v-model="email"
                  @blur="validateEmail">

              <p class="help is-danger" v-if="errors.email">
                Please enter a valid email.
              </p>
            </div>

            <!-- submit button -->
            <div class="field has-text-right">
              <button type="submit" class="button is-danger">
                Submit
              </button>
            </div>
          </form>

        </div>
      </div>
    </div>
  </div>

  <section class="container">
    <div class="columns is-multiline">
      <div class="column is-8 is-offset-2 register">
        <div class="columns">
          <div class="column left">
            <h1 class="title is-1">Super Cool Website</h1>
            <h2 class="subtitle colored is-4">Lorem ipsum dolor sit amet.</h2>
            <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Corporis ex deleniti aliquam tempora libero excepturi vero soluta odio optio sed.</p>
          </div>
          <div class="column right has-text-centered">
            <h1 class="title is-4">Sign up today</h1>
            <p class="description">Lorem ipsum dolor, sit amet consectetur adipisicing elit</p>
            <form>
              <div class="field">
                <div class="control">
                  <input class="input is-medium" type="text" placeholder="Name">
                </div>
              </div>

              <div class="field">
                <div class="control">
                  <input class="input is-medium" type="email" placeholder="Email">
                </div>
              </div>
              <button class="button is-block is-primary is-fullwidth is-medium">Submit</button>
              <br />
              <small><em>Lorem ipsum dolor sit amet consectetur.</em></small>
            </form>
          </div>
        </div>
      </div>
      <div class="column is-8 is-offset-2">
        <br>
        <nav class="level">
          <div class="level-left">
            <div class="level-item">
                <span class="icon">
                  <i class="fab fa-twitter"></i>
                </span> &emsp;
              <span class="icon">
                  <i class="fab fa-facebook"></i>
                </span> &emsp;
              <span class="icon">
                  <i class="fab fa-instagram"></i>
                </span> &emsp;
              <span class="icon">
                  <i class="fab fa-github"></i>
                </span> &emsp;
              <span class="icon">
                  <i class="fas fa-envelope"></i>
                </span>
            </div>
          </div>
          <div class="level-right">
            <small class="level-item" style="color: var(--textLight)">
              &copy; Super Cool Website. All Rights Reserved.
            </small>
          </div>
        </nav>
      </div>
    </div>
  </section>
  <!-- START NAV -->
  <nav class="navbar is-white">
    <div class="container">
      <div class="navbar-brand">
        <a class="navbar-item brand-text" href="../index.html">
          Bulma Admin
        </a>
        <div class="navbar-burger burger" data-target="navMenu">
          <span></span>
          <span></span>
          <span></span>
        </div>
      </div>
      <div id="navMenu" class="navbar-menu">
        <div class="navbar-start">
          <a class="navbar-item" href="admin.html">
            Home
          </a>
          <a class="navbar-item" href="admin.html">
            Orders
          </a>
          <a class="navbar-item" href="admin.html">
            Payments
          </a>
          <a class="navbar-item" href="admin.html">
            Exceptions
          </a>
          <a class="navbar-item" href="admin.html">
            Reports
          </a>
        </div>

      </div>
    </div>
  </nav>
  <!-- END NAV -->
  <div class="container">
    <div class="columns">
      <div class="column is-3 ">
        <aside class="menu is-hidden-mobile">
          <p class="menu-label">
            General
          </p>
          <ul class="menu-list">
            <li><a class="is-active">Dashboard</a></li>
            <li><a>Customers</a></li>
            <li><a>Other</a></li>
          </ul>
          <p class="menu-label">
            Administration
          </p>
          <ul class="menu-list">
            <li><a>Team Settings</a></li>
            <li>
              <a>Manage Your Team</a>
              <ul>
                <li><a>Members</a></li>
                <li><a>Plugins</a></li>
                <li><a>Add a member</a></li>
                <li><a>Remove a member</a></li>
              </ul>
            </li>
            <li><a>Invitations</a></li>
            <li><a>Cloud Storage Environment Settings</a></li>
            <li><a>Authentication</a></li>
            <li><a>Payments</a></li>
          </ul>
          <p class="menu-label">
            Transactions
          </p>
          <ul class="menu-list">
            <li><a>Payments</a></li>
            <li><a>Transfers</a></li>
            <li><a>Balance</a></li>
            <li><a>Reports</a></li>
          </ul>
        </aside>
      </div>
      <div class="column is-9">
        <nav class="breadcrumb" aria-label="breadcrumbs">
          <ul>
            <li><a href="../">Bulma</a></li>
            <li><a href="../">Templates</a></li>
            <li><a href="../">Examples</a></li>
            <li class="is-active"><a href="#" aria-current="page">Admin</a></li>
          </ul>
        </nav>
        <section class="hero is-info welcome is-small">
          <div class="hero-body">
            <div class="container">
              <h1 class="title">
                Hello, Admin.
              </h1>
              <h2 class="subtitle">
                I hope you are having a great day!
              </h2>
            </div>
          </div>
        </section>
        <section class="info-tiles">
          <div class="tile is-ancestor has-text-centered">
            <div class="tile is-parent">
              <article class="tile is-child box">
                <p class="title">439k</p>
                <p class="subtitle">Users</p>
              </article>
            </div>
            <div class="tile is-parent">
              <article class="tile is-child box">
                <p class="title">59k</p>
                <p class="subtitle">Products</p>
              </article>
            </div>
            <div class="tile is-parent">
              <article class="tile is-child box">
                <p class="title">3.4k</p>
                <p class="subtitle">Open Orders</p>
              </article>
            </div>
            <div class="tile is-parent">
              <article class="tile is-child box">
                <p class="title">19</p>
                <p class="subtitle">Exceptions</p>
              </article>
            </div>
          </div>
        </section>
        <div class="columns">
          <div class="column is-6">
            <div class="card events-card">
              <header class="card-header">
                <p class="card-header-title">
                  Events
                </p>
                <a href="#" class="card-header-icon" aria-label="more options">
                  <span class="icon">
                    <i class="fa fa-angle-down" aria-hidden="true"></i>
                  </span>
                </a>
              </header>
              <div class="card-table">
                <div class="content">
                  <table class="table is-fullwidth is-striped">
                    <tbody>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    <tr>
                      <td width="5%"><i class="fa fa-bell-o"></i></td>
                      <td>Lorum ipsum dolem aire</td>
                      <td class="level-right"><a class="button is-small is-primary" href="#">Action</a></td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </div>
              <footer class="card-footer">
                <a href="#" class="card-footer-item">View All</a>
              </footer>
            </div>
          </div>
          <div class="column is-6">
            <div class="card">
              <header class="card-header">
                <p class="card-header-title">
                  Inventory Search
                </p>
                <a href="#" class="card-header-icon" aria-label="more options">
                  <span class="icon">
                    <i class="fa fa-angle-down" aria-hidden="true"></i>
                  </span>
                </a>
              </header>
              <div class="card-content">
                <div class="content">
                  <div class="control has-icons-left has-icons-right">
                    <input class="input is-large" type="text" placeholder="">
                    <span class="icon is-medium is-left">
                      <i class="fa fa-search"></i>
                    </span>
                    <span class="icon is-medium is-right">
                      <i class="fa fa-check"></i>
                    </span>
                  </div>
                </div>
              </div>
            </div>
            <div class="card">
              <header class="card-header">
                <p class="card-header-title">
                  User Search
                </p>
                <a href="#" class="card-header-icon" aria-label="more options">
                  <span class="icon">
                    <i class="fa fa-angle-down" aria-hidden="true"></i>
                  </span>
                </a>
              </header>
              <div class="card-content">
                <div class="content">
                  <div class="control has-icons-left has-icons-right">
                    <input class="input is-large" type="text" placeholder="">
                    <span class="icon is-medium is-left">
                      <i class="fa fa-search"></i>
                    </span>
                    <span class="icon is-medium is-right">
                      <i class="fa fa-check"></i>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import ApiClient from "@/services/ApiClient";

export default {
  name: 'SearchForm',
  data() {
    return {
      name: '',
      email: '',
      errors: {
        name: false,
        email: false
      },
      search: null,
      api_errors: null,
      categories: [],
      server_info: null
    }
  },
  methods: {
    processForm() {
      console.log({name: this.name, email: this.email});
      alert('Processing');
    },
    validateEmail() {
      const isValid = window.isValidEmail(this.email);
      this.errors.email = !isValid;
    },
    getSearches() {
      ApiClient.getSearches()
          .then(response => this.search = response.data)
          .catch(error => this.api_errors = error)
    },
    getCategories() {
      ApiClient.getCategories()
          .then(response => this.categories = response.data)
          .catch(error => this.api_errors = error)
    },
    getServerInfo() {
      ApiClient.getServerInfo()
          .then(response => this.server_info = response.data)
          .catch(error => this.api_errors = error)
    }
  },
  created() {
    this.getCategories();
    this.getServerInfo();
    console.log(this.categories);
    console.log(this.server_info);
  }
}
</script>