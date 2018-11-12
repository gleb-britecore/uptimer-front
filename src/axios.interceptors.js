import axios from "axios";

axios.interceptors.request.use(
    config => {
      if (!config.headers.Authorization) {
        const token = localStorage.token;

        if (token) {
          config.headers.Authorization = `Token ${token}`;
        }
      }

      return config;
    },
    error => Promise.reject(error)
);