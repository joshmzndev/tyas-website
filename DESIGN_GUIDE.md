# TYAS Website — Page Fragment Design Guide

Derived from `mun.html`. Use it for any new or reworked page in this repo.

---

## 1. What these files are

Each `.html` file here is a **fragment** that gets pasted into the body of a CMS-managed TYAS page (a CKEditor-style rich-text field). The host page already supplies the `<html>`, `<head>`, site header/footer, fonts, the color variables, and the global layout classes.

So a fragment:

- Has **no** `<!doctype>`, `<html>`, `<head>`, `<body>`, `<link>` or `<script>` tags.
- Is a run of top-level `<section>` blocks followed by **one** `<style type="text/css">` block at the end.
- Must not restyle anything global (`body`, `h2`, `p`, `img`, `.wrapper`, …). Every rule is scoped to the page's own prefix or section IDs.

### File skeleton

```html
<!-- ===== SECTION 1: WHAT IS X ===== -->
<section id="xyz_intro">
<div class="workframe">
<div class="wrapper"><span class="xyz__eyebrow">About the Program</span>

<h2 class="xyz__heading">Two-Line<br />
Heading</h2>

<p class="xyz__para">…</p>
</div>
</div>
</section>
<!-- ===== SECTION 2: … ===== -->

<section id="xyz_next">
…
</section>
<!-- ===== STYLES ===== -->
<style type="text/css">/* ---- Shared ---- */
…
</style>
```

---

## 2. Host-provided building blocks (use, don't redefine)

| Provided by host | Purpose |
|---|---|
| `.workframe` > `.wrapper` | Page-width container and side gutters. Every section wraps its content in exactly these two divs. |
| `.img_cover` | Global image class. Put it on every content `<img>`. |
| `'Crimson Text'` | The site serif. Loaded by the host, so don't import it. |
| `--primary` | Brand accent: underline on emphasized text, featured item names. |
| `--complement` | Small-label color: eyebrows, roles, index numbers. |
| `--triadic2` | Strong/dark text: headings, names, `<strong>`. |
| `--triadic1` | Body text color. |
| `--info-rgb` | An RGB triplet for translucent lines/muted text: `rgba(var(--info-rgb), 0.15)`. |

Don't hard-code hex colors. Every color comes from these variables.

The CMS also exposes WOW.js-style classes (`wow delay1`, `wow delay2`, seen in older pages such as `strategic_plan.html`). `mun.html` doesn't use them; leave them out unless a page specifically asks for scroll-in animation.

---

## 3. Naming conventions

- **Page prefix:** a short lowercase slug for the page (`mun`, `mll`, `sfg`, …).
- **Section IDs:** `prefix_name` with an **underscore**, e.g. `mun_intro`, `mun_leadership`, `mun_conferences`.
- **Classes:** BEM-style with a **double underscore**: `prefix__block`, `prefix__block-part`, `prefix__block--modifier`.
  - Elements are hyphenated, not nested BEM: `mun__officer-photo`, `mun__officer-name`, `mun__conf-desc`.
  - Modifiers use `--`: `mun__figure--wide`, `mun__conf--featured`.
- Reuse the shared primitives under the prefix on every page: `__eyebrow`, `__heading`, `__para`, `__figure`.

### Comments

- Section banners in caps: `<!-- ===== SECTION 3: CONFERENCE CIRCUIT ===== -->`, and `<!-- ===== STYLES ===== -->` before the style block.
- Closing markers on long containers: `<!-- /.mun__conf-grid -->`, `<!-- /.wrapper -->`.
- In CSS, divide by section: `/* ---- Shared ---- */`, `/* ---- Section 2: Leadership ---- */`, `/* ---- Responsive ---- */`.

---

## 4. Markup style (match the CMS output)

The files are round-tripped through the CMS editor, so write markup the way the editor saves it. That keeps diffs small:

- Self-closing void tags: `<br />`, `<img … />`.
- Attributes in **alphabetical order**: `<img alt="…" class="img_cover" src="…" />`.
- HTML entities for punctuation: `&#39;` (apostrophe), `&quot;`, `&ndash;`, `&middot;`, `&amp;`.
- One blank line between block-level siblings (`h2`, `p`, `div`, `figure`, `article`).
- The first child of `.wrapper` (or another inline-starting container) sits on the same line as its opening tag: `<div class="wrapper"><span class="mun__eyebrow">…</span>`.
- `<li>` items are tab-indented. Nothing else is indented.
- Semantic tags: `<section>` for each band, `<article>` for repeatable cards, `<figure>` for images, `<ul>` for lists of points, `<h2>` for section headings, `<h3>` for card titles.

### Images

- Path: `/userfiles/images/article/<prefix>/<name>.jpg`.
- Always write descriptive `alt` text, e.g. `alt="Jonus Liew, Club President"` or `alt="Delegates in committee session"`.
- Always wrap images in a `<figure>`. Size the **figure** with `aspect-ratio`, then fill it with the image (`width/height: 100%; object-fit: cover; display: block`).

---

## 5. Typography

Everything is set in `'Crimson Text', sans-serif` (keep that exact stack for consistency) and declared on each class. Don't rely on inheritance.

| Role | Class pattern | Size | Weight / style | Other | Color |
|---|---|---|---|---|---|
| Eyebrow / small label | `__eyebrow`, `__officer-role` | 14px | 600, oblique | UPPERCASE, `letter-spacing: 3px`, `margin-bottom: 16px` | `--complement` |
| Section heading (h2) | `__heading` | `clamp(46px, 5vw, 72px)` | 600 | UPPERCASE, `line-height: 110%`, `margin: 0 0 48px` | `--triadic2` |
| Card title, large (h3) | `__conf-name` | `clamp(32px, 3vw, 46px)` | 600 | `line-height: 100%` | `--triadic2` (`--primary` when featured) |
| Card title, medium (h3) | `__officer-name` | 28px | 600 | | `--triadic2` |
| List-item title | `__pillar-title` | 22px | 600 | | `--triadic2` |
| Lead / body paragraph | `__para` | `clamp(20px, 1.6vw, 26px)` | 400 | `line-height: 170%`, `letter-spacing: 0.5px`, `margin: 0` | `--triadic1` |
| Card body | `__officer-bio`, `__conf-desc`, `__pillar-body` | 18px | 400 | `line-height: 160–165%`, `letter-spacing: 0.5px` | `--triadic1` |
| Sub-label / caption | `__conf-full` | 15px | 600, oblique | UPPERCASE, `letter-spacing: 1px` | `rgba(var(--info-rgb), 0.5)` |
| Index number | `__conf-num` | 13px | 600, oblique | `letter-spacing: 3px`, zero-padded (`01`, `02`…) | `--complement` |

**Heading pattern:** every section opens with *eyebrow → h2 → content*. The h2 is split onto two balanced lines with `<br />` ("Our Student<br />Leadership"). The eyebrow carries context such as a category, season (`2025&ndash;2026 Season`) or place/date (`2026 &middot; Fukuoka, Japan`).

**Emphasis in lead paragraphs** (`__para strong`): weight 700, color `--triadic2`, and a 2px `--primary` underline with `text-underline-offset: 4px`. Inside card body text, `<strong>` only darkens (no underline). `<em>` is used for quoted themes.

---

## 6. Layout and spacing

### Section rhythm
- Every top-level section: `padding: 6vw 0;`. List all the section IDs together in one rule under `/* ---- Shared ---- */`.
- Sections have no background color or card chrome. Separation comes from whitespace and hairlines.

### Spacing scale (px)
Stick to these values: **4, 6, 8, 10, 12, 16, 20, 24, 32, 40, 48, 56, 80**.

| Use | Value |
|---|---|
| Heading → content | 48 (32 when the heading sits in a grid column) |
| Hero image / intro paragraph → next block | 56 |
| Vertical flow in a content column | `gap: 40px` |
| Card grid gap | 40 |
| Image pair gap | 20 |
| Two-column text grid gap | 80 |
| Card internal padding | 48 |
| Gap inside a card (photo → text) | 24 |

### Line length
Constrain standalone intro paragraphs with `max-width: 720px`.

### Grid patterns
- **Two-column split** (`__intro-grid`): `1fr 1fr`, `gap: 80px`, `align-items: start`. Text on the left, supporting list on the right.
- **Three-up cards** (`__officers`): `repeat(3, 1fr)`, `gap: 40px`.
- **Hairline 2×N grid** (`__conf-grid`): `1fr 1fr`. Cells get a top border, and even cells add a left border and swap their padding side. The effect is a ruled table rather than boxed cards.
- **Image pair** (`__duo`): `1fr 1fr`, `gap: 20px`, figures at `4/3`.
- **Vertical content flow** (`__content`): `flex-direction: column; gap: 40px` for alternating paragraphs and images.

---

## 7. Lines, shapes and imagery

### Hairlines
The only borders are `1px solid rgba(var(--info-rgb), 0.15)`. Use them to:
- Separate stacked list items (top border on each, plus a bottom border on `:last-child`).
- Rule card grids (see above).

There are no box shadows, no filled card backgrounds, and no rounded boxes.

### The signature "leaf" corner
Images get **one or two large rounded corners** and keep the rest square:

| Shape | `border-radius` |
|---|---|
| Bottom-right (default) | `0 0 130px 0` |
| Top-left | `130px 0 0 0` |
| Diagonal leaf | `130px 0 130px 0` |

- Alternate shapes across a row so neighboring images mirror each other. Officers go bottom-right → leaf → top-left. The duo goes bottom-right → top-left.
- At ≤640px, reduce the radius to **60px** and simplify to bottom-right, except where mirroring still reads well.
- Always pair it with `overflow: hidden` and `margin: 0` on the `<figure>`.

### Aspect ratios
| Image type | Desktop | ≤640px |
|---|---|---|
| Wide/hero banner (`__figure--wide`) | `16/7` | `4/3` |
| Image pair (`__duo`) | `4/3` | `4/3` |
| Portrait (people) | `3/4` | `3/4` |

### Hover
Images get a slow zoom inside their frame, and nothing else animates:
```css
img { transition: transform 0.6s ease-in-out; }
figure:hover img { transform: scale(1.03); } /* 1.04 for portraits */
```

---

## 8. Components (reference implementations in `mun.html`)

| Component | Classes | Notes |
|---|---|---|
| Hero image | `__figure __figure--wide __hero` | Full width, 16/7, leaf corner, `margin-bottom: 56px`. |
| Section header | `__eyebrow` + `__heading` | Required at the top of every section. |
| Pillar list | `ul.__pillars > li.__pillar > span.__pillar-title + span.__pillar-body` | Unstyled list with hairline separators, 24px vertical padding. |
| Profile card | `__officer > figure.__officer-photo + div.__officer-info > span.__officer-role + h3.__officer-name + p.__officer-bio` | Portrait photo, role as eyebrow, name, bio. |
| Numbered entry | `article.__conf > span.__conf-num + h3.__conf-name + p.__conf-full + p.__conf-desc` | Index number, short name, full-name caption, description. |
| Featured modifier | `__conf--featured` | Only the title changes, to `--primary`. Keep highlighting this subtle. |
| Image pair | `__duo > figure.__figure ×2` | Mirrored corners. |

---

## 9. Responsive behavior

Write desktop-first and put all overrides in one `/* ---- Responsive ---- */` block at the end of the stylesheet, using these three breakpoints:

| Breakpoint | Changes |
|---|---|
| `max-width: 1024px` | Two-column split collapses to one (gap 48). Three-up cards become two-up, and the orphaned third spans the row with `max-width: 400px`. |
| `max-width: 768px` | Hairline 2-col grid becomes one column. Remove the left borders and use symmetric padding (`48px 0`). |
| `max-width: 640px` | Everything is one column. Leaf radii shrink to 60px, wide images go to 4/3, and image pairs stack. |

Fluid type comes from `clamp()` on the heading, lead paragraph and large card titles. Section padding scales with `vw`.

---

## 10. Content voice

- Formal, warm and institutional: "We are incredibly proud of…", "a historic milestone".
- Name the school as **Taoyuan American School (TYAS)** on first mention and **TYAS** after that.
- Expand acronyms once: the short name goes in the title (`HSINMUN`), the full name in the caption (`Hsinchu Model United Nations`).
- Use `<strong>` for proper nouns and key achievements, and `<em>` for quoted themes.

---

## 11. Checklist for a new fragment

- [ ] No document-level tags. Sections, then one trailing `<style type="text/css">`.
- [ ] A page prefix is chosen. IDs use `prefix_name`, classes use `prefix__part`.
- [ ] Each section is `section#id > .workframe > .wrapper` and opens with eyebrow + two-line h2.
- [ ] Every color is a host CSS variable. No hex values.
- [ ] Every text class declares `'Crimson Text', sans-serif` and a size from the type table.
- [ ] Images are `<figure>`-wrapped, use `class="img_cover"`, have real alt text, use `/userfiles/images/article/<prefix>/`, have an aspect ratio, a leaf corner and the hover zoom.
- [ ] Spacing values come from the scale. Separators are 0.15-alpha hairlines only.
- [ ] Responsive block covers 1024 / 768 / 640.
- [ ] Markup is in CMS style: `<br />`, entities, alphabetical attributes, blank lines between blocks.
- [ ] No global selectors.

---

## 12. Known quirks in `mun.html` to avoid copying

- The hero image (`mun-1.jpg`) appears in both Section 1 and Section 4. Use each image once per page.
- `.mun__conf--featured { background: transparent; }` is a no-op. Don't add placeholder rules.
- The image-fill rules (`width/height 100%`, `object-fit`, transition) are repeated for `__officer-photo`, `__figure--wide` and `__duo`. In new pages, write them once on `.prefix__figure img` and `.prefix__figure:hover img`.
- `__officer-role` duplicates `__eyebrow`. Reuse the eyebrow class, or group the selectors.
- Bare `.mun__figure` (not `--wide`, not in a duo) has no image-fill rule. If you use a standalone figure, give it the shared fill rule above.
