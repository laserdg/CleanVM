import json
from textual.app import App, ComposeResult
from textual.containers import Horizontal, Vertical, VerticalScroll
from textual.widgets import Header, SelectionList, Label, Button, Markdown, Select


def savejson(data):
    with open('options.json', 'w', encoding='utf-8') as f:
        json.dump(data, f)


Head = """
# CleanVM

> Browser-first VM powered by KasmVNC

CleanVM is a lightweight, browser-only virtual machine built for speed and simplicity. It keeps the desktop minimal, defaults to i3, and gives you a fast KasmVNC browser experience.

- Minimal desktop setup
- Default browser: Helium
- One-page installer flow
- KasmVNC access on port 3000
- Optimized for performance and low overhead
"""

LINES = ["I3 (Very Lightweight)", "KDE Plasma (Heavy)", "XFCE4 (Lightweight)", "GNOME 42 (Very Heavy)", "Cinnamon", "LXQT"]


class InstallApp(App):
    CSS_PATH = "installer.tcss"

    def compose(self) -> ComposeResult:
        yield Header()
        with VerticalScroll():
            yield Markdown(Head)
            yield Vertical(
                Vertical(
                    Label("Default apps"),
                    SelectionList[int](
                        ("Helium Browser", 0, True),
                        id="defaultapps",
                    ),
                ),
                Vertical(
                    Label("Programming"),
                    SelectionList[int](
                        ("OpenJDK 8 (jre)", 0),
                        ("OpenJDK 17 (jre)", 1),
                        ("VSCodium", 2),
                        id="programming",
                    ),
                ),
                Vertical(
                    Label("Apps"),
                    SelectionList[int](
                        ("VLC", 0),
                        ("LibreOffice", 1),
                        ("Synaptic", 2),
                        ("AQemu (VMs)", 3),
                        ("TLauncher", 4),
                        id="apps",
                    ),
                ),
                Horizontal(
                    Label("Desktop environment:"),
                    Select(
                        id="de",
                        value="I3 (Very Lightweight)",
                        options=((line, line) for line in LINES),
                    ),
                ),
                Button.success("Install CleanVM", id="install"),
            )

    def _selected_values(self, widget):
        selected = widget.selected
        if not selected:
            return []
        if isinstance(selected, set):
            return sorted(selected)
        if isinstance(selected, list):
            return selected
        return list(selected)

    def on_button_pressed(self, event: Button.Pressed) -> None:
        if event.button.id == "install":
            data = {
                "defaultapps": self._selected_values(self.query_one("#defaultapps")),
                "programming": self._selected_values(self.query_one("#programming")),
                "apps": self._selected_values(self.query_one("#apps")),
                "enablekvm": True,
                "DE": self.query_one("#de").value,
                "install": True,
            }
            savejson(data)
            self.exit()


if __name__ == "__main__":
    app = InstallApp()
    app.run()
