// apiClient.js
let accessToken = null;

export function setAccessToken(token) {
    accessToken = token;
}

export async function apiRequest(path, options = {}) {
    if (!options.headers) options.headers = {};
    if (accessToken) {
        options.headers["Authorization"] = "Bearer " + accessToken;
    }

    options.credentials = "include";

    let res = await fetch(import.meta.env.VITE_API_URL + path, options);

    if (res.status === 401) {
        const newToken = await refreshAccessToken();
        if (!newToken) {
            console.warn("Refresh gagal. User harus login ulang.");
            return null;
        }

        options.headers["Authorization"] = "Bearer " + newToken;

        // ulang request
        res = await fetch(import.meta.env.VITE_API_URL + path, options);
    }

    return res.json();
}

async function refreshAccessToken() {
    const res = await fetch(import.meta.env.VITE_API_URL + "/refresh", {
        method: "POST",
        credentials: "include"
    });

    if (!res.ok) return null;

    const data = await res.json();
    setAccessToken(data.accessToken);

    return data.accessToken;
}
