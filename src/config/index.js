let base_url = 'http://192.168.99.101:30636'
base_url = 'http://0.0.0.0:8000'

var apiRoot = base_url

if (window.DOCKER_API_ROOT) {
  apiRoot = window.DOCKER_API_ROOT
}


var config = {
  url: apiRoot
}

export default config