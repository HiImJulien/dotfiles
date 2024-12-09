import { App } from "astal/gtk3";
import Launcher from "@widgets/launcher";

import css from "./src/app.scss";

App.start({
  css: css,
  main() {
    <Launcher />;
  },
});
