
/**
 * @param {number} monitor - The id of the monitor this widget is displayed on.
 */
function Left(monitor) {
    return Widget.Box({
        css: "padding: 1px;",
        child: Widget.Revealer()
    });
}


/**
 * @param {number} monitor - The id of the monitor this widget is displayed on.
 */
function Center(monitor) {
    return Widget.Box({
        css: "padding: 1px;",
        child: Widget.Label({ label: "Hello, World!" })
    });
}


/**
 * @param {number} monitor - The id of the monitor this widget is displayed on.
 */
function Right(monitor) {
    return Widget.Box({
        css: "padding: 1px;",
        child: Widget.Revealer()
    });
}


/**
 * @param {number} monitor - The id of the monitor to launch the bar on.
 */
export function Bar(
    monitor
) {
    return Widget.Window({
        name: `bar-${monitor}`,
        className: "bar",
        monitor,
        anchor: ["left", "top", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            startWidget: Left(monitor),
            centerWidget: Center(monitor),
            endWidget: Right(monitor)
        })
    });
}
