<template>
    <div class="login-container">

        <el-form ref="loginForm" :model="loginForm" class="login-form" auto-complete="on" label-position="left">

            <div class="title-container">
                <h3 class="title">Sign in into Uptimer</h3>
            </div>

            <el-form-item prop="username">

                <el-input
                        v-model="loginForm.username"
                        :placeholder="'Username'"
                        name="username"
                        type="text"
                        auto-complete="on"
                />
            </el-form-item>

            <el-form-item prop="password">

                <el-input
                        type="password"
                        v-model="loginForm.password"
                        :placeholder="'Password'"
                        name="password"
                        auto-complete="on"
                        @keyup.enter.native="handleLogin"/>
            </el-form-item>

            <el-button :loading="loading" type="primary" style="width:100%;margin-bottom:30px;"
                       @click.native.prevent="handleLogin">Sign in
            </el-button>



        </el-form>



    </div>
</template>

<script>
  /* eslint-disable */
  // import { isvalidUsername } from '@/utils/validate'
  // import LangSelect from '@/components/LangSelect'
  // import SocialSign from './socialsignin'
  import axios from "axios";
  import config from "../config";

  export default {
    name: 'login.page',
    // components: { LangSelect, SocialSign },
    data() {

      return {
        loginForm: {
          username: '',
          password: ''
        },

        loading: false,
        redirect: undefined
      }
    },
    watch: {
      $route: {
        handler: function (route) {
          this.redirect = route.query && route.query.redirect
        },
        immediate: true
      }
    },

    methods: {

      async handleLogin() {
          this.loading = true

        try {
          let response = await axios.post(config.url + '/auth/login/', this.loginForm)
          localStorage.token = response.data.token
          this.$router.push({path: this.redirect || '/'})
        } finally {
          this.loading = false

        }

      },
      afterQRScan() {
        // const hash = window.location.hash.slice(1)
        // const hashObj = getQueryObject(hash)
        // const originUrl = window.location.origin
        // history.replaceState({}, '', originUrl)
        // const codeMap = {
        //   wechat: 'code',
        //   tencent: 'code'
        // }
        // const codeName = hashObj[codeMap[this.auth_type]]
        // if (!codeName) {
        //   alert('第三方登录失败')
        // } else {
        //   this.$store.dispatch('LoginByThirdparty', codeName).then(() => {
        //     this.$router.push({ path: '/' })
        //   })
        // }
      }
    }
  }
</script>
<style scoped>
    .login-form {
        width: 500px;
        margin: 120px auto;
    }
</style>