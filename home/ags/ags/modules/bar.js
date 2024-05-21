
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
 * Contains the center widget comprised of a label, that displays the current
 * time. On click it open the calendar.
 * @param {number} monitor - The id of the monitor this widget is displayed on.
 */
function Center(monitor) {
    const date = Variable("", {
        poll: [1000, "date \"+%a %H:%M\""]
    });

    return Widget.EventBox({
        on_primary_click: () => {
            console.log("Click!");
        },
        child: Widget.Label({
            label: date.bind()
        })
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
