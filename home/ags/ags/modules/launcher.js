import { Application } from "resource:///com/github/Aylur/ags/service/applications.js";
import { hyprland } from "resource:///com/github/Aylur/ags/service/hyprland.js";

const { query } = await Service.import("applications");

/**
/* @param {Application} app - The application this item represents.
 * @param {string} parentTitle - The title of the parent window.
 */
function LauncherItem(app, parentTitle) {
  const onClickApp = () => {
    App.closeWindow(parentTitle);
    app.launch();
  };

  const box = Widget.EventBox({
    className: "launcher__item",
    attribute: { app },
    on_primary_click: onClickApp,
    child: Widget.Box({
      children: [
        Widget.Icon({
          icon: app.icon_name || "",
          size: 42,
        }),
        Widget.Label({
          className: "title",
          label: app.name,
          xalign: 0,
          vpack: "center",
          truncate: "end",
        }),
      ],
    }),
  });

  return box;
}

/**
 * @param {string} title - The title of the launcher window.
 * @param {number} [width=600] - The width of the launcher window.
 * @param {number} [height=600] - The height of the launcher window.
 * @param {number} [spacing=12] - The spacing between items in the launcher window.
 */
function LauncherWidget(
  title = "Launcher",
  width = 600,
  height = 600,
  spacing = 12,
) {
  const applications = query("").map((app) => LauncherItem(app, title));
  const applicationsList = Widget.Box({
    className: "launcher__container",
    vertical: true,
    children: applications,
    spacing,
  });

  return Widget.Box({
    vertical: true,
    css: `margin: ${spacing * 2}px;`,
    children: [
      Widget.Scrollable({
        hscroll: "never",
        css: `min-width: ${width}px; min-height: ${height}px;`,
        child: applicationsList,
      }),
    ],
    setup: (self) =>
      self.hook(App, (_, windowName, _visible) => {
        if (windowName !== title) return;
      }),
  });
}

/**
 * @param {string} title - The title of the launcher window.
 * @param {number} [width=600] - The width of the launcher window.
 * @param {number} [height=600] - The height of the launcher window.
 * @param {number} [spacing=12] - The spacing between items in the launcher window.
 */
export function Launcher(
  title = "launcher",
  width = 600,
  height = 600,
  spacing = 12,
) {
  return Widget.Window({
    className: "launcher",
    monitor: hyprland.active.monitor.id,
    name: title,
    setup: (self) => {
      self.keybind("Escape", () => App.closeWindow(title));
      self.bind("monitor", hyprland.active.monitor, "id", id => { self.monitor = id; return id;});
    },
    visible: false,
    keymode: "on-demand",
    child: LauncherWidget(title, width, height, spacing),
  });
}
