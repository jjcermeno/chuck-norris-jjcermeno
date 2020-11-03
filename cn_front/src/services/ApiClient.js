import axios from 'axios'

const apiClient = axios.create({
    baseURL: 'http://127.0.0.1:3000/api/v1',
    headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json'
    },
    timeout: 30000 // throw error if API call takes longer than 10 seconds
})

export default {
    getSearches(perPage, page) {
        return apiClient.get(`/searches?page=${page}&limit=${perPage}`)
    },
    getSearch(id, perPage, page) {
        return apiClient.get(`/searches/${id}?page=${page}&limit=${perPage}`)
    },
    createSearch(form_data) {
        return apiClient.post('/searches', form_data)
    },
    getCategories() {
        return apiClient.get('/categories')
    }
}