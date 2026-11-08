#!/bin/sh
# Toggle this SketchyBar configuration between its original colors and Contrast white.
set -eu

mode=${1:-toggle}
case "$mode" in
  toggle|current|contrast|status) ;;
  *) printf 'Usage: %s [toggle|current|contrast|status]\n' "$0" >&2; exit 2 ;;
esac

config_dir=${SKETCHYBAR_CONFIG_DIR:-"$HOME/.config/sketchybar"}
python3 - "$config_dir" "$mode" <<'PY'
import os
import stat
import subprocess
import sys
import tempfile
from pathlib import Path

root = Path(sys.argv[1]).expanduser()
requested = sys.argv[2]
paths = {
    "bar": root / "sketchybarrc",
    "colors": root / "colors.sh",
    "space": root / "scripts" / "aerospace.sh",
}
try:
    original = {name: path.read_text() for name, path in paths.items()}
except OSError as exc:
    raise SystemExit(f"Cannot read SketchyBar configuration: {exc}")

# Appended only in Contrast mode. Removing this exact block restores colors.sh byte for byte.
override = (
    "# BEGIN sketchybar-contrast-toggle\n"
    "export ORANGE=0xff000000\n"
    "export LABEL_COLOR=0xff6e6e6e\n"
    "export ITEM_BG_COLOR=0xfff0f0f0\n"
    "export ACCENT_COLOR=0xff000000\n"
    "# END sketchybar-contrast-toggle\n"
)
changes = {
    "bar": [
        ("  color=0xff1E2021 \\", "  color=0xffffffff \\"),
        ("border_color=0x20FFFFFF", "border_color=0xff000000"),
        ("border_width=0", "border_width=2"),
        ("shadow.color=0x80000000", "shadow.color=0x33000000"),
        ("background.color=0xffD79920", "background.color=0xff000000"),
        ("label.color=0xff000000", "label.color=0xffffffff"),
    ],
    "space": [
        ("label.color=0xff000000", "label.color=0xffffffff"),
        ("icon.color=0xff000000", "icon.color=0xffffffff"),
    ],
}

def has_exactly_one(text, needle):
    return text.count(needle) == 1

def matches(which):
    for name, pairs in changes.items():
        for current, contrast in pairs:
            expected, other = (current, contrast) if which == "current" else (contrast, current)
            if not has_exactly_one(original[name], expected) or other in original[name]:
                return False
    if which == "current":
        return override not in original["colors"] and "# BEGIN sketchybar-contrast-toggle" not in original["colors"]
    return has_exactly_one(original["colors"], override)

if matches("current"):
    active = "current"
elif matches("contrast"):
    active = "contrast"
else:
    raise SystemExit("Configuration differs from both known palettes; no files changed.")

if requested == "status":
    print(active)
    raise SystemExit(0)
target = ("contrast" if active == "current" else "current") if requested == "toggle" else requested
if target == active:
    print(f"Already {active}; no files changed.")
    raise SystemExit(0)

proposed = original.copy()
for name, pairs in changes.items():
    text = original[name]
    for current, contrast in pairs:
        source, dest = (current, contrast) if target == "contrast" else (contrast, current)
        text = text.replace(source, dest, 1)
    proposed[name] = text
if target == "contrast":
    proposed["colors"] += override
else:
    proposed["colors"] = proposed["colors"].replace(override, "", 1)

def replace_files(contents):
    staged = []
    try:
        for name, path in paths.items():
            fd, temp_name = tempfile.mkstemp(prefix=f".{path.name}.contrast-", dir=path.parent)
            temp = Path(temp_name)
            staged.append((temp, path))
            with os.fdopen(fd, "w") as stream:
                stream.write(contents[name])
                stream.flush()
                os.fsync(stream.fileno())
            temp.chmod(stat.S_IMODE(path.stat().st_mode))
        for temp, path in staged:
            os.replace(temp, path)
    finally:
        for temp, _ in staged:
            temp.unlink(missing_ok=True)

try:
    replace_files(proposed)
    if os.environ.get("SKETCHYBAR_THEME_SKIP_RELOAD") != "1":
        subprocess.run(["sketchybar", "--reload"], check=True)
except Exception as exc:
    replace_files(original)
    if os.environ.get("SKETCHYBAR_THEME_SKIP_RELOAD") != "1":
        subprocess.run(["sketchybar", "--reload"], check=False)
    raise SystemExit(f"Switch failed and original files were restored: {exc}")
print(f"Switched {active} -> {target}.")
PY
