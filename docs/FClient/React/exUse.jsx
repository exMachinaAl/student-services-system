import { useState } from "react";
import { apiRequest, setAccessToken } from "./apiClient";

export default function exUse() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [result, setResult] = useState("");

    async function login() {
        const res = await fetch(import.meta.env.VITE_API_URL + "/login", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            credentials: "include",
            body: JSON.stringify({ email, password })
        });

        const data = await res.json();
        setAccessToken(data.accessToken);

        setResult("Login success! AT: " + data.accessToken);
    }

    async function getProtected() {
        const data = await apiRequest("/protected");
        setResult(JSON.stringify(data, null, 2));
    }

    return (
        <div style={{ padding: 20 }}>
            <h1>React Auth Test</h1>

            <div>
                <input
                    placeholder="email"
                    value={email}
                    onChange={e => setEmail(e.target.value)}
                />
                <input
                    type="password"
                    placeholder="password"
                    value={password}
                    onChange={e => setPassword(e.target.value)}
                />
                <button onClick={login}>Login</button>
            </div>

            <button onClick={getProtected}>Get Protected Data</button>

            <pre>{result}</pre>
        </div>
    );
}
