import { App } from "astal/gtk3";

import { Bar, ControlCenter, Launcher } from "@widgets";

import css from "./src/app.scss";

App.start({
  icons: `${SRC}/assets`,
  css: css,
  main() {
    <Launcher />;
    const monitors = App.get_monitors();
    monitors.forEach((monitor) => {
      Bar({ monitor });
      ControlCenter({ app: App, monitor });
    });
  },
});
