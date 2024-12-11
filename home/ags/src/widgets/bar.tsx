import { GLib, Variable, bind } from "astal";
import { Astal, App, Gtk, Gdk } from "astal/gtk3";

import Hyprland from "gi://AstalHyprland";

import { hideControlCenter, toggleControlCenter } from "./control-center";

const WINDOW_NAME = "shell::bar";

type BarProps = {
  monitor: Gdk.Monitor;
};

type WorkspacesProps = {
  hypr: Hyprland.Hyprland;
  halign: Gtk.Align;
};

const Workspaces = ({ hypr, halign }: WorkspacesProps) => {
  return (
    <box className="bar__ws" halign={halign} hexpand>
      {bind(hypr, "workspaces").as((wss) =>
        wss
          .sort((a, b) => a.id - b.id)
          .map((ws) => (
            <button
              className="bar__ws__item"
              onClicked={() => ws.focus()}
              widthRequest={16}
              heightRequest={16}>
              {ws.get_name()}
            </button>
          )),
      )}
    </box>
  );
};

type ControlCenterTriggerProps = {
  halign: Gtk.Align;
  monitor: Gdk.Monitor;
};

const ControlCenterTrigger = ({
  halign,
  monitor,
}: ControlCenterTriggerProps) => {
  const onClick = () => {
    toggleControlCenter(monitor);
  };

  return (
    <eventbox halign={halign} hexpand className="bar__ctrl" onClick={onClick}>
      <icon icon="lucide-ellipsis-vertical-symbolic" />
    </eventbox>
  );
};

const TimeLabel = () => {
  const getTime = () => GLib.DateTime.new_now_local().format("%H:%M")!;
  const time = Variable<string>("").poll(1000, getTime);

  return (
    <box>
      <label
        className="bar__time"
        onDestroy={() => time.drop()}
        label={time()}
      />
    </box>
  );
};

const Bar = ({ monitor }: BarProps) => {
  const anchor =
    Astal.WindowAnchor.LEFT | Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT;

  const displayName = monitor.get_display().get_name();
  const windowName = `${WINDOW_NAME}::${displayName}`;

  const hypr = Hyprland.get_default();

  // Hide the control center if the workspace is being switched.
  bind(hypr, "focusedWorkspace").subscribe(() => {
    hideControlCenter();
  });

  return (
    <window
      name={windowName}
      anchor={anchor}
      application={App}
      className="bar"
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      gdkmonitor={monitor}
      heightRequest={32}>
      <centerbox>
        <Workspaces hypr={hypr} halign={Gtk.Align.START} />
        <TimeLabel />
        <ControlCenterTrigger halign={Gtk.Align.END} monitor={monitor} />
      </centerbox>
    </window>
  );
};

export default Bar;
