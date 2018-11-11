<template>
    <div class="sites-root">

        <H1>Sites2</H1>


        <el-input placeholder="Site Url" v-model="newUrl"></el-input>

        <el-button type="primary" @click="addSite()" :disabled="newUrl === ''">Add</el-button>
        <el-table v-loading="loading"
                :data="all"
                style="width: 100%">
            <el-table-column
                    label="Operations"
                    width="180">
                <template slot-scope="scope">
                    <el-button @click="refresh_site(scope.row)">
                        Refresh Status
                    </el-button>
                </template>
            </el-table-column>
            <el-table-column
                    prop="status"
                    label="Status"
                    width="100">
                <template slot-scope="scope">
                    <el-tag
                            style="min-width: 100px; text-align: center;"
                            class="u-text--center"
                            :type="buildLabelColor(scope.row)"
                            close-transition>{{scope.row.status}}</el-tag>

                </template>
            </el-table-column>


            <el-table-column
                    prop="site_url"
                    label="Site Url"
            >
            </el-table-column>


            <el-table-column
                    prop="status_code"
                    label="Status Code"
            >
            </el-table-column>
            <el-table-column
                    label="Operations"
                    width="180">
                <template slot-scope="scope">
                    <el-button type="danger" @click="delete_site(scope.row)">
                        Delete
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
  import axios from 'axios';
  /* eslint-disable */
  export default {
    name: "sites.page",

    data() {
      this.loadAllSites()
      return {
        newUrl: '',
        all : [
          {
            url: 'xxxx',
            status: 200,
          }],
        loading: false,
      }
    },
    computed: {

    },
    methods: {
      buildLabelColor (build) {
        if (!build || !build.status) {
          return 'primary'
        }
        let statusNormalized = build.status
        if (statusNormalized === 'queued') {
          return 'primary'
        }

        if (statusNormalized === 'succeeded') {
          return 'success'
        }

        if (statusNormalized === 'fail') {
          return 'danger'
        }

        return 'primary'
      },
      async addSite() {
        this.all.push({site_url: this.newUrl})
        let a = await axios.post('http://localhost:8000/sites/', {site_url: this.newUrl})
        this.loadAllSites()

        console.log('asdasd', a.data)

        this.clear()
      },
      async delete_site (site) {
        // debugger
        console.log(site)
        let response = await axios.delete(site.url)
        this.loadAllSites()
      },
      clear() {

        this.newUrl = ''
      },
      async loadAllSites () {
        this.loading = true

        try {
          let response = await axios.get('http://localhost:8000/sites/')
          this.all = response.data
          console.log(response)
        } catch (e) {
        } finally {
          this.loading = false
        }


      },
      async refresh_site(site) {
        let response = await axios.patch(site.url)
        this.loadAllSites()

      },
    },
  }
</script>

<style scoped>

</style>