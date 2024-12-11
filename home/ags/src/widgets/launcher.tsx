import { Astal, App, Gtk, Gdk } from "astal/gtk3";
import Apps from "gi://AstalApps";

const WINDOW_NAME = "shell::launcher";

const hideLauncher = () => {
  const window = App.get_window(WINDOW_NAME);
  if (!window) return;

  window.hide();
};

const Application = (app: Apps.Application) => {
  const onClick = () => {
    hideLauncher();
    app.launch();
  };

  return (
    <button onClick={onClick} className="launcher__item">
      <box heightRequest={72}>
        <icon icon={app.iconName} className="launcher__item__icon" />
        <label label={app.name} truncate />
      </box>
    </button>
  );
};

const Launcher = () => {
  const apps = new Apps.Apps();
  apps.showHidden = true;

  const applications = apps.get_list();

  const onKeyPress = (self: Gtk.Window, event: Gdk.Event) => {
    const key = event.get_keyval()[1];
    if (key === Gdk.KEY_Escape) {
      self.hide();
    }
  };

  return (
    <window
      application={App}
      className="launcher"
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      name={WINDOW_NAME}
      heightRequest={500}
      widthRequest={500}
      onKeyPressEvent={onKeyPress}
      visible={false}>
      <scrollable>
        <box vertical>{applications.map(Application)}</box>
      </scrollable>
    </window>
  );
};

export default Launcher;
