<template>
    <div class="sites-root">

        <H1>Sites2</H1>


        <el-input placeholder="Site Url" v-model="newUrl"></el-input>

        <el-button type="primary" @click="addSite()" :disabled="newUrl === ''">Add</el-button>
        <el-table
                :data="all"
                style="width: 100%">
            <el-table-column
                    prop="status"
                    label="Status"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="url"
                    label="Url"
                    >
            </el-table-column>

        </el-table>
    </div>
</template>

<script>
  export default {
    name: "sites.page",
    data() {
      return {
        newUrl: '',
        all: [
          {
            url: 'xxxx',
            status: 200,
          }]
      }
    },
    methods: {
      addSite() {
        this.all.push({url: this.newUrl})
        this.clear()
      },
      clear() {
        this.newUrl = ''
      },
    },
  }
</script>

<style scoped>

</style>