<div align="center">

# CTOS — Plasma 6 Splash Screen

A clean, minimalist splash screen for **KDE Plasma 6** inspired by the ctOS boot sequence.

Just a centered animation on a pure black screen.

</div>

<br/>
<div align="center">

<img src="assets/animation.gif" alt="CTOS splash animation" width="420"/>

<sub>The actual splash animation, playing in real time.</sub>

</div>

---

## Why

Most splash screens clutter the boot with logos, distribution names, and spinners. **CTOS** keeps it simple — a centered animation on a pure black screen, and nothing else. It installs as its own entry named **CTOS** in your Splash Screen settings.

## Requirements

- KDE Plasma **6** (not compatible with Plasma 5)

Check your version:

```bash
plasmashell --version
```

## Install

Pick whichever method you're comfortable with.

### Method 1 — One-line script (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/debarch777/ctos-plasma-splash/main/install.sh -o /tmp/ctos-install.sh && bash /tmp/ctos-install.sh
```

### Method 2 — Manual (.zip download)

1. Go to **[Releases](https://github.com/debarch777/ctos-plasma-splash/releases)**
2. Download `CTOS.zip`
3. Unzip so you have a folder called `CTOS` containing `metadata.json` and `contents/`
4. Move it into place:
   ```bash
   mv CTOS ~/.local/share/plasma/look-and-feel/
   ```

### Method 3 — Git clone

```bash
git clone https://github.com/debarch777/ctos-plasma-splash.git
cp -r ctos-plasma-splash/src/CTOS ~/.local/share/plasma/look-and-feel/
```

## Activate

After installing with any method above:

1. Open **System Settings → Appearance → Splash Screen**
2. If **CTOS** doesn't appear yet, restart Plasma so it rescans:
   ```bash
   kquitapp6 plasmashell && kstart plasmashell
   ```
   (or just log out and back in)
3. Select **CTOS** → **Apply**
4. Hit the **Test** button to preview without rebooting

## Uninstall

```bash
rm -rf ~/.local/share/plasma/look-and-feel/CTOS
```
Then pick a different splash in System Settings.

## How it works

The theme is a Plasma Look-and-Feel package. The layout lives in
[`src/CTOS/contents/splash/Splash.qml`](src/CTOS/contents/splash/Splash.qml) —
just a fullscreen black `Rectangle` with a centered `AnimatedImage` playing
`animation.gif`. That's it.

Tweak freely:

- **Change the animation** — replace `src/CTOS/contents/splash/images/animation.gif`
- **Change the size** — edit the `sizeAnim: 704` value in `Splash.qml`
- **Background color** — change `color: "#000"` in `Splash.qml`

## File structure

```
ctos-plasma-splash/
├── src/
│   └── CTOS/                          ← the installable theme folder
│       ├── metadata.json              ← theme id/name (shows as "CTOS")
│       └── contents/
│           ├── previews/
│           │   └── splash.png         ← thumbnail in settings
│           └── splash/
│               ├── Splash.qml         ← the layout (black + centered gif)
│               └── images/
│                   └── animation.gif  ← the CTOS-style animation
├── install.sh                         ← one-line installer
├── assets/                            ← repo graphics (animation, social card)
└── README.md
```

## License

- Code (`Splash.qml`) licensed under **GPLv2+**. See [LICENSE](LICENSE).
- Animation artwork © its respective authors.
- "ctOS" references the fictional operating system from Ubisoft's *Watch Dogs*;
  this project is not affiliated with or endorsed by Ubisoft or KDE.
