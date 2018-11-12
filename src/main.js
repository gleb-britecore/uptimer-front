import Vue from 'vue'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI)
Vue.use(require('vue-moment'));

import VueTimers from 'vue-timers'
Vue.use(VueTimers)

import './axios.interceptors'

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
