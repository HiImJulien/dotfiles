import { Launcher } from "./modules/launcher.js";
import { Bar } from "./modules/bar.js";

const CSS_PATH = `${App.configDir}/modules/style.css`;

App.config({
    windows: [Launcher(), Bar(0), Bar(1)],
    style: CSS_PATH
});

