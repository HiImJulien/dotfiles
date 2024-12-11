import { bind, exec } from "astal";
import { Astal, App, Gtk, Gdk } from "astal/gtk3";

import Hyprland from "gi://AstalHyprland";
import Wp from "gi://AstalWp";

import { Separator } from "@components";

const DeviceMenu = () => {
  return (
    <box className="ctrl-center__dev" homogeneous hexpand vertical={false}>
      <box>
        <icon className="icon" icon="lucide-bluetooth-symbolic" />
      </box>
      <box>
        <icon className="icon" icon="lucide-ethernet-port-symbolic" />
      </box>
      <box>
        <icon className="icon" icon="lucide-ethernet-port-symbolic" />
      </box>
      <box>
        <icon className="icon" icon="lucide-ethernet-port-symbolic" />
      </box>
    </box>
  );
};

type VolumeSliderProps = {
  device: Wp.Endpoint;
};

const VolumeSlider = ({ device }: VolumeSliderProps) => {
  const onDragged = ({ value }: any) => {
    device.volume = value;
  };

  return (
    <slider
      className="slider"
      onDragged={onDragged}
      hexpand
      drawValue={false}
      value={bind(device, "volume")}
    />
  );
};

type IconVolumeSlider = {
  iconName: string;
} & VolumeSliderProps;

const IconVolumeSlider = ({ iconName, device }: IconVolumeSlider) => {
  return (
    <box vexpand>
      <icon className="icon" icon={iconName} />
      <VolumeSlider device={device} />
    </box>
  );
};

type PowerMenuProps = {};

const PowerMenu = ({}: PowerMenuProps) => {
  const hypr = Hyprland.get_default();

  const onLockClicked = (_self: any, event: Astal.ClickEvent) => {
    if (event.button == Astal.MouseButton.PRIMARY) console.log("Clicked lock!");
  };
  const onSleepClicked = (_self: any, event: Astal.ClickEvent) => {
    if (event.button == Astal.MouseButton.PRIMARY) exec("systemctl suspend");
  };
  const onLogoutClicked = (_self: any, event: Astal.ClickEvent) => {
    if (event.button == Astal.MouseButton.PRIMARY)
      hypr.message("dispatch exit");
  };
  const onPowerOffClicked = (_self: any, event: Astal.ClickEvent) => {
    if (event.button == Astal.MouseButton.PRIMARY) exec("poweroff");
  };

  return (
    <box className="ctrl-center__power" homogeneous hexpand vertical={false}>
      <eventbox onClick={onLockClicked}>
        <icon className="icon" icon="lucide-lock-symbolic" />
      </eventbox>
      <eventbox onClick={onSleepClicked}>
        <icon className="icon" icon="lucide-moon-symbolic" />
      </eventbox>
      <eventbox onClick={onLogoutClicked}>
        <icon className="icon" icon="lucide-logout-symbolic" />
      </eventbox>
      <eventbox onClick={onPowerOffClicked}>
        <icon className="icon" icon="ldpd-symbolic" />
      </eventbox>
    </box>
  );
};

type ControlCenterProps = {
  app: Astal.Application;
  monitor: Gdk.Monitor;
};

const ControlCenter = ({ app, monitor }: ControlCenterProps) => {
  const anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT;
  const windowName = makeControlCenterName(monitor);

  const wp = Wp.get_default();
  const defaultSpeaker = wp?.defaultSpeaker!;
  const defaultMicrophone = wp?.defaultMicrophone!;

  const onKeyEnter = (self: Gtk.Window, event: Gdk.Event) => {
    const key = event.get_keyval()[1];
    if (key === Gdk.KEY_Escape) {
      self.hide();
    }
  };

  return (
    <window
      application={app}
      className="ctrl-center"
      anchor={anchor}
      name={windowName}
      gdkmonitor={monitor}
      visible={false}
      widthRequest={300}
      onKeyPressEvent={onKeyEnter}
      keymode={Astal.Keymode.ON_DEMAND}
      layer={Astal.Layer.OVERLAY}>
      <box vertical vexpand>
        <DeviceMenu />
        <Separator
          orientation={Gtk.Orientation.HORIZONTAL}
          className="separator"
        />
        <IconVolumeSlider
          iconName="lucide-volume2-symbolic"
          device={defaultSpeaker}
        />
        <IconVolumeSlider
          iconName="lucide-mic-symbolic"
          device={defaultMicrophone}
        />
        <Separator
          orientation={Gtk.Orientation.HORIZONTAL}
          className="separator"
        />
        <PowerMenu />
      </box>
    </window>
  );
};

/**
 *
 */
const makeControlCenterName = (monitor: Gdk.Monitor) => {
  const displayName = monitor.get_display().get_name();
  const windowName = `shell::control-center::${displayName}`;

  return windowName;
};

const getControlCenterWindow = (monitor: Gdk.Monitor) => {
  const windowName = makeControlCenterName(monitor);
  return App.get_window(windowName);
};

const openControlCenter = (monitor: Gdk.Monitor) => {
  const window = getControlCenterWindow(monitor);
  if (window && !window.visible) {
    window.show();
  }
};

const hideControlCenter = (monitor?: Gdk.Monitor) => {
  // Hide all instances regardless of monitor.
  if (!monitor) {
    App.get_windows()
      .filter((w) => w.name.startsWith("shell::control-center"))
      .forEach((w) => w.hide());

    return;
  }

  const window = getControlCenterWindow(monitor);
  if (window && window.visible) {
    window.hide();
  }
};

const toggleControlCenter = (monitor: Gdk.Monitor) => {
  const windowName = makeControlCenterName(monitor);
  App.toggle_window(windowName);
};

export default ControlCenter;
export { openControlCenter, hideControlCenter, toggleControlCenter };
