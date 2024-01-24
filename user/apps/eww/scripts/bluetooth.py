#!/usr/bin/env python3

from gi.repository import GLib
from pydbus import SystemBus
from argparse import ArgumentParser

import xml.etree.ElementTree as ET
import json


def introspect_object(object):
    spec = object.Introspect()
    spec = ET.fromstring(spec)
    ET.indent(spec)
    print(ET.tostring(spec, encoding="unicode"))


class Device:

    def __init__(self, adapter: "Adapter", path: str, device):
        self._adapter = adapter
        self._path = path
        self._device = device


    @property
    def address(self) -> str:
        return self._device.Address

    @property 
    def battery_level(self):
        return self._device.Percentage

    @property 
    def name(self):
        return self._device.Name

    @property 
    def is_connected(self) -> bool:
        return self._device.Connected

    def connect(self):
        self._device.Connect()

    def disconnect(self):
        self._device.Disconnect()


class Adapter:

    def __init__(self, service: "BlueZService", path: str, adapter):
        self._service = service
        self._path = path
        self._adapter = adapter
        self._is_powered = self._adapter.Powered
        self._is_discovering = self._adapter.Discovering
        self._adapter.onPropertiesChanged = lambda i, p, a: self.__on_property_changed(i, p, a)
        self._report_status = False

        spec = self._adapter.Introspect()
        spec = ET.fromstring(spec)

        devices = spec.findall("node")
        self._devices = [self.__get_device(device) for device in devices]

    @property 
    def path(self) -> str:
        return self._path

    @property 
    def devices(self) -> [Device]:
        return self._devices

    @property
    def address(self) -> str:
        return self._adapter.Address

    @property
    def name(self) -> str:
        return self._adapter.Name

    @property
    def is_powered(self) -> bool:
        return self._adapter.Powered

    @is_powered.setter
    def is_powered(self, val: bool):
        self._adapter.Powered = val

    @property
    def is_discovering(self) -> bool:
        return self._adapter.Discovering

    @property
    def report_status(self):
        """The report_status property."""
        return self._report_status

    @report_status.setter
    def report_status(self, value):
        self._report_status = value

    def print_status(self):
        status = {
            "is_powered": self.is_powered,
            "is_discovering": self.is_discovering
        }

        print(json.dumps(status), flush=True)

    def start_discovery(self):
        self._adapter.StartDiscovery()

    def stop_discovery(self):
        self._adapter.StopDiscovery()

    def __get_device(self, device_node):
        device_id = device_node.get("name")
        device_path = f"{self.path}/{device_id}"
        device = self._service.bus.get(BlueZService.SERVICE_NAME, device_path)

        return Device(self, device_path, device)

    def __on_property_changed(self, interface, str, props: dict, _):
        is_powered = props.get("Powered", None)
        if is_powered:
            self._is_powered = is_powered

        is_discovering = props.get("Discovering", None)
        if is_discovering:
            self._is_discovering = is_discovering

        if self.report_status:
            print_status()

class BlueZService:
    SERVICE_NAME = "org.bluez"
    SERVICE_PATH = "/org/bluez"

    def __init__(self, bus: SystemBus = SystemBus()):
        self._bus = bus
        self._bluez = self._bus.get(BlueZService.SERVICE_NAME)
        self._adapter = self.__get_default_adapter()

    @property
    def bus(self) -> SystemBus:
        return self._bus

    @property
    def default_adapter(self):
        return self._adapter

    def get_object(self, path: str):
        return self._bus.get(BlueZService.SERVICE_NAME, path)

    def __get_default_adapter(self) -> Adapter:
        spec = ET.fromstring(self._bluez.Introspect())
        adapters = spec.findall("node")

        if not adapters:
            raise RuntimeError("No bluetooth adapters were found.")

        adapter_name = adapters[0].attrib.get("name")
        adapter_path = f"{BlueZService.SERVICE_PATH}/{adapter_name}"
        adapter = self.get_object(adapter_path)

        return Adapter(self, adapter_path, adapter)


def watch_adapter():
    service = BlueZService()
    adapter = service.default_adapter
    adapter.print_status()
    GLib.MainLoop().run()


def list_devices():
    service = BlueZService()
    adapter = service.default_adapter
    devices = []

    for dev in adapter.devices:
        device = { 
            "name": dev.name, 
            "address": dev.address,
            "is_connected": dev.is_connected, 
            "battery": dev.battery_level
        }

        devices.append(device)

    print(json.dumps(devices))



def main():
    parser = ArgumentParser(
        prog = "bluetooth",
        description = "Utility to interact with bluetooth from eww."
    )

    parser.add_argument("action", choices=["watch-adapter", "list-devices"])
    args = parser.parse_args()

    if args.action == "watch-adapter":
        watch_adapter()
    elif args.action == "list-devices":
        list_devices()



if __name__ == "__main__":
    main()

