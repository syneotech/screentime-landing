# Screenshots

The hero carousel on `index.html` expects these files (1080×1920 PNG or JPG, phone portrait):

| File | Label shown if image missing |
|---|---|
| `01-catalog.png` | Approved catalog |
| `02-time-limits.png` | Daily time limits |
| `03-activity.png` | Activity log |
| `04-kids-mode.png` | Kids mode |
| `05-timeout-popup.png` | Timeout popup |
| `06-time-up.png` | Time's up |

Drop files with these exact names into this folder — no HTML edits needed. If a file is absent, the slide shows the text label on the surface color instead of a broken-image icon.

To change slide count or labels, edit the `.slide` entries inside `#screenshots` in `index.html` (and the matching `.carousel-dot` buttons below them).
