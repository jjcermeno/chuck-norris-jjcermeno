import axios from 'axios'

const apiClient = axios.create({
    baseURL: 'http://127.0.0.1:3030/api/v1',
    headers: {
        Accept: 'application/json',
        // 'Content-Type': 'application/json'
    },
    timeout: 30000 // throw error if API call takes longer than 30 seconds
})

export default {
    getSearches(page=1, per_page=5) {
        return apiClient.get(`/searches?pageNumber=${page}&pageSize=${per_page}`)
    },
    getSearch(id, page=1, per_page=5) {
        return apiClient.get(`/searches/${id}?pageNumber=${page}&pageSize=${per_page}`)
    },
    resendEmail(id) {
        return apiClient.get(`/searches/${id}/resend_email`)
    },
    createSearch(form_data) {
        return apiClient.post('/searches', form_data)
    },
    getCategories() {
        return apiClient.get('/categories')
    },
    getServerInfo() {
        return apiClient.get('/info')
    }
}