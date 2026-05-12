// ID APP: #
// PUBLIC CODE: #
// Webhook: #

const express = require("express");
const axios = require("axios");
const fs = require("fs");

const app = express();
const PORT = 9000;

// Discord Webhook URL
const DISCORD_WEBHOOK_URL = "#";

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

async function sendDiscord(message) {
    await axios.post(DISCORD_WEBHOOK_URL, {
        username: "Snort IDS",
        content: message,
    });
}

app.post("/alert", async (req, res) => {
    try {
        const now = new Date().toISOString();

        const alertText =
            req.body.alert ||
            req.body.message ||
            JSON.stringify(req.body, null, 2);

        const clientIp =
            req.headers["x-forwarded-for"] ||
            req.socket.remoteAddress ||
            "unknown";

        const message = `🚨 **Snort Alert from VM**

**Time:** ${now}
**Source VM:** ${clientIp}

\`\`\`
${alertText}
\`\`\``;

        console.log("\n" + message);

        fs.appendFileSync("snort_alerts_from_vm.log", message + "\n\n");

        await sendDiscord(message);

        res.status(200).send("OK");
    } catch (error) {
        console.error("Error:", error.message);
        res.status(500).send("ERROR");
    }
});

app.get("/", (req, res) => {
    res.send("Snort Discord receiver is running");
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Snort Discord receiver listening on 0.0.0.0:${PORT}`);
});