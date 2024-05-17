import { Launcher } from "./modules/launcher.js";

App.config({
    windows: [Launcher()],
    style: `${App.configDir}/modules/style.css`
});
