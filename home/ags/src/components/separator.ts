import { astalify, ConstructProps, Gtk } from "astal/gtk3";

import GObject from "gi://GObject";

class Separator extends astalify(Gtk.Separator) {
  static {
    GObject.registerClass(this);
  }

  constructor(
    props: ConstructProps<Separator, Gtk.Separator.ConstructorProps>,
  ) {
    super(props as any);
  }
}

export default Separator;
